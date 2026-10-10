//
//  PDFListTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 06.13.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Testing
@testable import TPPDF

struct PDFListTests {
    @Test func initializingListPreservesLevelIndentationsAndStartsEmpty() {
        // Arrange
        let indentations: [(pre: CGFloat, past: CGFloat)] = [(0, 10), (10, 10), (20, 10)]

        // Act
        let list = PDFList(indentations: indentations)
        let initialCount = list.count

        // Assert
        #expect(initialCount == 0)
        for index in indentations.indices {
            #expect(list.levelIndentations[index].pre == indentations[index].pre)
            #expect(list.levelIndentations[index].past == indentations[index].past)
        }
    }

    @Test func addingItemReturnsListAndPreservesContentAndSymbol() {
        // Arrange
        let list = PDFList(indentations: [(0, 10), (10, 10), (20, 10)])
        let item = PDFListItem(symbol: .dash, content: "Item 1")

        // Act
        let result = list.addItem(item)

        // Assert
        #expect(result === list)
        #expect(list.count == 1)
        #expect(list.items[0].content == "Item 1")
        #expect(list.items[0].symbol.rawValue == "dash")
    }

    @Test func clearingThenAddingNestedItemsFlattensLevelsContentAndInheritedSymbols() throws {
        // Arrange
        let list = PDFList(indentations: [(0, 10), (10, 10), (20, 10)])
        list.addItem(PDFListItem(symbol: .dash, content: "Item 1"))
        let items = [
            PDFListItem(symbol: .dot, content: "Base 1").addItems([
                PDFListItem(symbol: .numbered(value: nil)).addItems([
                    PDFListItem(content: "Child 2.1"),
                    PDFListItem(symbol: .none, content: "Child 2.2"),
                    PDFListItem(content: "Child 2.3"),
                ]),
            ]),
            PDFListItem(symbol: .dash, content: "Base 2").addItems([
                PDFListItem(content: "Child 2.1").addItems([
                    PDFListItem(symbol: .dot, content: "Child 2.1.1"),
                ]),
                PDFListItem(content: "Child 2.2").addItems([
                    PDFListItem(symbol: .dash, content: "Child 2.2.1"),
                ]),
            ]),
        ]
        let expectedItems = [
            (0, "Base 1", "dot"), (1, "Child 2.1", "numbered|1"), (1, "Child 2.2", "none"),
            (1, "Child 2.3", "numbered|3"), (0, "Base 2", "dash"), (1, "Child 2.1", "dash"),
            (2, "Child 2.1.1", "dot"), (1, "Child 2.2", "dash"), (2, "Child 2.2.1", "dash"),
        ]

        // Act
        list.clear()
        let result = list.addItems(items)
        let flattened = list.flatted()

        // Assert
        #expect(result === list)
        try #require(flattened.count == 9)
        for (index, expected) in expectedItems.enumerated() {
            #expect(flattened[index].level == expected.0)
            #expect(flattened[index].text == expected.1)
            #expect(flattened[index].symbol.rawValue == expected.2)
        }
    }
}
