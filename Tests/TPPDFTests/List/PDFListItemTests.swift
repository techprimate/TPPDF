//
//  PDFListItemTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 05.12.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Testing
@testable import TPPDF

struct PDFListItemTests {
    @Test func initializingWithoutArgumentsUsesInheritedSymbolAndNoContentOrRelations() {
        // Arrange
        let expectedSymbol = "inherit"

        // Act
        let item = PDFListItem()

        // Assert
        #expect(item.parent == nil)
        #expect(item.content == nil)
        #expect(item.children == nil)
        #expect(item.symbol.rawValue == expectedSymbol)
    }

    @Test func initializingWithSymbolPreservesSymbol() {
        // Arrange
        let symbol = PDFListItemSymbol.dash

        // Act
        let item = PDFListItem(symbol: symbol)

        // Assert
        #expect(item.symbol.rawValue == "dash")
    }

    @Test func initializingWithContentPreservesContent() {
        // Arrange
        let content = "EXAMPLE"

        // Act
        let item = PDFListItem(content: content)

        // Assert
        #expect(item.content == content)
    }

    @Test(arguments: [1, 2])
    func addingChildrenReturnsParentAndPreservesParentLinksContentAndSymbols(count: Int) throws {
        // Arrange
        let parent = PDFListItem()
        let items = [PDFListItem(symbol: .dash, content: "A1"), PDFListItem(symbol: .dot, content: "A2")]

        // Act
        let result = count == 1 ? parent.addItem(items[0]) : parent.addItems(items)

        // Assert
        #expect(result === parent)
        let children = try #require(parent.children)
        try #require(children.count == count)
        for index in 0..<count {
            #expect(children[index].parent === parent)
            #expect(children[index].content == items[index].content)
            #expect(children[index].symbol.rawValue == items[index].symbol.rawValue)
        }
    }

    @Test func settingContentReturnsItemAndUpdatesContent() {
        // Arrange
        let item = PDFListItem()
        let content = "RANDOMNEWCONTENT"

        // Act
        let result = item.setContent(content)

        // Assert
        #expect(result === item)
        #expect(item.content == content)
    }
}
