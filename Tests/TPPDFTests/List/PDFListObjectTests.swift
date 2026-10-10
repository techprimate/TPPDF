//
//  PDFListObjectTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 06.12.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Testing
@testable import TPPDF

struct PDFListObjectTests {
    @Test func initializingListObjectPreservesList() {
        // Arrange
        let list = makeList()

        // Act
        let object = PDFListObject(list: list)

        // Assert
        #expect(object.list == list)
    }

    @Test func calculatingNestedListPreservesEverySymbolTextAndFrame() throws {
        // Arrange
        let object = PDFListObject(list: makeList())
        let document = PDFDocument(format: .a4)
        let generator = PDFGenerator(document: document)
        let xOffsets: [CGFloat] = [10, 20, 10, 20, 10, 20, 20, 30, 30, 20, 30, 10, 20]
        let expectedTexts = [
            "1.", "Heading 1", "?.", "Heading 2", "\u{00B7}", "Heading 3", "-",
            "Subheading 1", "Subheading 2", "\u{00B7}", "Subheading 3", "+", "Heading 4",
        ]
        #if os(watchOS)
        let expectedWidths: [CGFloat] = [12, 76.2, 13, 78, 5.4, 79, 6.9, 104.5, 106, 5.4, 106.2, 9.47, 79]
        #elseif targetEnvironment(macCatalyst)
        let expectedWidths: [CGFloat] = [12, 78, 13, 80, 4, 81, 8, 106.4, 108.8, 4, 109.2, 11, 81.2]
        #else
        let expectedWidths: [CGFloat] = [12, 75, 13, 78, 4, 79, 8, 103, 106, 4, 105.4, 11, 79]
        #endif
        #if (os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)) && !targetEnvironment(macCatalyst)
        let expectedYPositions: [CGFloat] = [60, 60, 81, 81, 102, 102, 123, 123, 144, 165, 165, 186, 186]
        let expectedHeight: CGFloat = 21
        #else
        let expectedYPositions: [CGFloat] = [60, 60, 80, 80, 100, 100, 120, 120, 140, 160, 160, 180, 180]
        let expectedHeight: CGFloat = 20
        #endif

        // Act
        let result = try object.calculate(generator: generator, container: .contentLeft)

        // Assert
        try #require(result.count == 13)
        for index in result.indices {
            #expect(result[index].0 == .contentLeft)
            let item = try #require(result[index].1 as? PDFAttributedTextObject)
            #expect(item.frame.origin.x == document.layout.margin.left + xOffsets[index])
            #expect(item.frame.origin.y == expectedYPositions[index])
            #expect(abs(item.frame.width - expectedWidths[index]) < 1)
            #expect(item.frame.height == expectedHeight)
            #expect(item.simpleText == PDFSimpleText(text: expectedTexts[index]))
        }
    }

    @Test func calculatingWithoutIndentationsPositionsSymbolAndContentAtLeftMargin() throws {
        // Arrange
        let list = makeList()
        list.levelIndentations = []
        let object = PDFListObject(list: list)
        let document = PDFDocument(format: .a4)
        let generator = PDFGenerator(document: document)
        #if targetEnvironment(macCatalyst)
        let expectedContentWidth: CGFloat = 78.2
        #else
        let expectedContentWidth: CGFloat = 76
        #endif
        #if (os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)) && !targetEnvironment(macCatalyst)
        let expectedHeight: CGFloat = 21
        #else
        let expectedHeight: CGFloat = 20
        #endif

        // Act
        let result = try object.calculate(generator: generator, container: .contentLeft)

        // Assert
        try #require(result.count == 13)
        #expect(result[0].0 == .contentLeft)
        #expect(result[1].0 == .contentLeft)
        #expect(result[2].0 == .contentLeft)
        let symbol = try #require(result[0].1 as? PDFAttributedTextObject)
        let content = try #require(result[1].1 as? PDFAttributedTextObject)
        #expect(symbol.frame.origin.x == document.layout.margin.left)
        #expect(symbol.frame.origin.y == 60)
        #expect(abs(symbol.frame.width - 12) < 1)
        #expect(symbol.frame.height == expectedHeight)
        #expect(symbol.simpleText == PDFSimpleText(text: "1."))
        #expect(content.frame.origin.x == document.layout.margin.left)
        #expect(content.frame.origin.y == 60)
        #expect(abs(content.frame.width - expectedContentWidth) < 1)
        #expect(content.frame.height == expectedHeight)
        #expect(content.simpleText == PDFSimpleText(text: "Heading 1"))
    }

    private func makeList() -> PDFList {
        let list = PDFList(indentations: [(pre: 10, past: 10), (pre: 20, past: 10)])
        list.addItem(PDFListItem(symbol: .numbered(value: "1"), content: "Heading 1"))
            .addItem(PDFListItem(symbol: .numbered(value: nil), content: "Heading 2"))
            .addItem(PDFListItem(symbol: .dot, content: "Heading 3")
                .addItem(PDFListItem(symbol: .dash, content: "Subheading 1"))
                .addItem(PDFListItem(symbol: .none, content: "Subheading 2"))
                .addItem(PDFListItem(symbol: .inherit, content: "Subheading 3")))
            .addItem(PDFListItem(symbol: .custom(value: "+"), content: "Heading 4"))
        return list
    }
}
