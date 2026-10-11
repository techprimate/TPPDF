//
//  PDFGroupObjectTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.10.2026.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Foundation
import Testing
@testable import TPPDF

struct PDFGroupObjectTests {
    @Test(arguments: [false, true], [false, true])
    func calculatingGroupRestoresEnclosingPaddingBeforeFollowingText(moveToNextPage: Bool, enclosingPadding: Bool) throws {
        // Arrange
        let document = PDFDocument(layout: PDFPageLayout(
            size: CGSize(width: 200, height: 240), margin: EdgeInsets(top: 20, left: 20, bottom: 20, right: 20), space: (0, 0)
        ))
        let generator = PDFGenerator(document: document)
        let originalPadding = enclosingPadding ? EdgeInsets(top: 3, left: 4, bottom: 5, right: 6) : .zero
        generator.currentPadding = originalPadding
        if moveToNextPage {
            let height = PDFCalculations.calculateAvailableFrameHeight(for: generator, in: .contentLeft)
            generator.layout.heights.content = height - 10
        }
        let object = PDFGroupObject(
            objects: [(.left, PDFAttributedTextObject(simpleText: PDFSimpleText(text: "GROUP")))],
            allowsBreaks: false, isFullPage: false, backgroundColor: nil, backgroundImage: nil, backgroundShape: nil,
            outline: .none, padding: EdgeInsets(top: 10, left: 24, bottom: 10, right: 32)
        )
        let following = PDFAttributedTextObject(simpleText: PDFSimpleText(text: "AFTER"))

        // Act
        let result = try object.calculate(generator: generator, container: .contentLeft)
        let restoredPadding = generator.currentPadding
        _ = try following.calculate(generator: generator, container: .contentLeft)

        // Assert
        #expect(result.contains { $0.1 is PDFPageBreakObject } == moveToNextPage)
        #expect(restoredPadding == originalPadding)
        #expect(generator.currentPadding == originalPadding)
        #expect(following.frame.minX == 20 + originalPadding.left)
        #expect(object.frame.minY == 20)
        #expect(following.frame.minY >= object.frame.maxY)
    }

    @Test(arguments: [CGFloat(0), 10, 25], [false, true])
    func breakableGroupPreservesPaddingAcrossPagesAndWrappedColumns(topPadding: CGFloat, wrapColumns: Bool) throws {
        // Arrange
        let document = PDFDocument(layout: PDFPageLayout(
            size: CGSize(width: 200, height: 180), margin: EdgeInsets(top: 20, left: 20, bottom: 20, right: 20), space: (5, 5)
        ))
        let generator = PDFGenerator(document: document)
        generator.layout.heights.header[.headerLeft] = 20
        generator.layout.heights.footer[.footerLeft] = 15
        if wrapColumns {
            _ = try PDFColumnWrapSectionObject(columns: 2, widths: [0.5, 0.5], spacings: [10])
                .calculate(generator: generator, container: .contentLeft)
        }
        let source = NSAttributedString(string: (0..<40).map { "LINE\($0)END" }.joined(separator: "\n"),
                                        attributes: [.font: Font.systemFont(ofSize: 10)])
        let object = PDFGroupObject(
            objects: [(.left, PDFAttributedTextObject(attributedText: PDFAttributedText(text: source)))],
            allowsBreaks: true, isFullPage: false, backgroundColor: .blue, backgroundImage: nil, backgroundShape: nil,
            outline: .none, padding: EdgeInsets(top: topPadding, left: 6, bottom: 10, right: 6)
        )

        // Act
        let result = try object.calculate(generator: generator, container: .contentLeft)
        let groups = result.compactMap { $0.1 as? PDFGroupObject }
        let texts = result.compactMap { $0.1 as? PDFAttributedTextObject }

        // Assert
        try #require(groups.count > 1)
        try #require(groups.count == texts.count)
        #expect(result.contains { ($0.1 as? PDFPageBreakObject)?.stayOnSamePage == true } == wrapColumns)
        for (group, text) in zip(groups, texts) {
            #expect(group.frame.minY == 45)
            #expect(text.frame.minY == 45 + topPadding)
            #expect(text.frame.minY - group.frame.minY == topPadding)
            #expect(group.frame.maxY <= 140)
        }
        let renderedText = texts.map { $0.attributedString.string }.joined()
        #expect(renderedText == source.string)
        #expect(generator.currentPadding == .zero)
    }

    @Test func failedGroupCalculationRestoresEnclosingPadding() {
        // Arrange
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        let originalPadding = EdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
        generator.currentPadding = originalPadding
        let group = PDFGroupObject(
            objects: [(.left, PDFTableObject(table: PDFTable(rows: 0, columns: 0)))],
            allowsBreaks: false, isFullPage: false, backgroundColor: nil, backgroundImage: nil, backgroundShape: nil,
            outline: .none, padding: EdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
        )

        // Act
        let error = #expect(throws: PDFError.self) {
            try group.calculate(generator: generator, container: .contentLeft)
        }

        // Assert
        guard case .tableIsEmpty? = error else {
            Issue.record("Expected tableIsEmpty, got \(String(describing: error))")
            return
        }
        #expect(generator.currentPadding == originalPadding)
    }
}
