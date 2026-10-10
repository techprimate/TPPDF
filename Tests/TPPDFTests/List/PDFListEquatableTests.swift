//
//  PDFListEquatableTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 05.12.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Testing
@testable import TPPDF

struct PDFListEquatableTests {
    @Test func listsWithSameIndentationsAndItemsAreEqual() {
        // Arrange
        let list = PDFList(indentations: [(pre: 5, past: 10)])
        let otherList = PDFList(indentations: [(pre: 5, past: 10)])

        // Act
        let isEqual = list == otherList

        // Assert
        #expect(isEqual)
    }

    @Test(arguments: [false, true])
    func differentIndentationsMakeListsUnequal(addLevel: Bool) {
        // Arrange
        let list = PDFList(indentations: [(pre: 5, past: 10)])
        let otherList = PDFList(indentations: [(pre: 10, past: 20)])
        if addLevel {
            otherList.levelIndentations.append((pre: 10, past: 10))
        }

        // Act
        let isEqual = list == otherList

        // Assert
        #expect(!isEqual)
    }

    @Test(arguments: [false, true])
    func differentItemCountsOrContentMakeListsUnequal(sameItemCount: Bool) {
        // Arrange
        let list = PDFList(indentations: [(pre: 5, past: 10)])
        let otherList = PDFList(indentations: [(pre: 5, past: 10)])
        otherList.addItem(PDFListItem(symbol: .dash, content: "CONTENT"))
        if sameItemCount {
            list.addItem(PDFListItem(symbol: .dash, content: "ANOTHERONE"))
        }

        // Act
        let isEqual = list == otherList

        // Assert
        #expect(!isEqual)
    }
}
