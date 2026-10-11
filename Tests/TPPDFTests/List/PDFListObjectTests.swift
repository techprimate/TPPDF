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
        let expectations: [(text: String, indent: CGFloat, line: Int, width: CGFloat, watchWidth: CGFloat, catalystWidth: CGFloat)] = [
            ("1.", 10, 0, 12, 12, 12),
            ("Heading 1", 20, 0, 75, 76.2, 78),
            ("?.", 10, 1, 13, 13, 13),
            ("Heading 2", 20, 1, 78, 78, 80),
            ("\u{00B7}", 10, 2, 4, 5.4, 4),
            ("Heading 3", 20, 2, 79, 79, 81),
            ("-", 20, 3, 8, 6.9, 8),
            ("Subheading 1", 30, 3, 103, 104.5, 106.4),
            ("Subheading 2", 30, 4, 106, 106, 108.8),
            ("\u{00B7}", 20, 5, 4, 5.4, 4),
            ("Subheading 3", 30, 5, 105.4, 106.2, 109.2),
            ("+", 10, 6, 11, 9.47, 11),
            ("Heading 4", 20, 6, 79, 79, 81.2),
        ]
        #if (os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)) && !targetEnvironment(macCatalyst)
        let expectedHeight: CGFloat = 21
        #else
        let expectedHeight: CGFloat = 20
        #endif

        // Act
        let result = try object.calculate(generator: generator, container: .contentLeft)

        // Assert
        try #require(result.count == expectations.count)
        for (index, expected) in expectations.enumerated() {
            #if os(watchOS)
            let width = expected.watchWidth
            #elseif targetEnvironment(macCatalyst)
            let width = expected.catalystWidth
            #else
            let width = expected.width
            #endif
            #expect(result[index].0 == .contentLeft)
            let item = try #require(result[index].1 as? PDFAttributedTextObject)
            #expect(item.frame.origin.x == document.layout.margin.left + expected.indent)
            #expect(item.frame.origin.y == 60 + CGFloat(expected.line) * expectedHeight)
            #expect(abs(item.frame.width - width) < 1, "Width for \(expected.text)")
            #expect(item.frame.height == expectedHeight)
            #expect(item.simpleText == PDFSimpleText(text: expected.text))
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
