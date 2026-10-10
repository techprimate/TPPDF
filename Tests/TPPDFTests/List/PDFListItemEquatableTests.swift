//
//  PDFListItemEquatableTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 05.12.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Testing
@testable import TPPDF

struct PDFListItemEquatableTests {
    @Test func defaultItemsAreEqual() {
        // Arrange
        let item = PDFListItem()
        let otherItem = PDFListItem()

        // Act
        let isEqual = item == otherItem

        // Assert
        #expect(isEqual)
    }

    @Test(arguments: ["content", "children", "symbol"])
    func changingItemValuesMakesItemsUnequal(property: String) {
        // Arrange
        let item = PDFListItem()
        let otherItem = PDFListItem()
        switch property {
        case "content": otherItem.content = "RANDOM"
        case "children": otherItem.children = [PDFListItem()]
        default: otherItem.symbol = .custom(value: "RANDOM")
        }

        // Act
        let isEqual = item == otherItem

        // Assert
        #expect(!isEqual)
    }
}
