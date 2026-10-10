//
//  PDFTableCellBordersEquatableTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.16.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Testing
@testable import TPPDF

struct PDFTableCellBordersEquatableTests {
    @Test func defaultBordersAreEqual() {
        // Arrange
        let borders = PDFTableCellBorders()
        let otherBorders = PDFTableCellBorders()

        // Act
        let isEqual = borders == otherBorders

        // Assert
        #expect(isEqual)
    }

    @Test(arguments: ["left", "top", "right", "bottom"])
    func changingAnyBorderMakesBordersUnequal(edge: String) {
        // Arrange
        let borders = PDFTableCellBorders()
        let style = PDFLineStyle(type: .dotted, color: .orange, width: 10)
        var otherBorders = PDFTableCellBorders()
        switch edge {
        case "left": otherBorders.left = style
        case "top": otherBorders.top = style
        case "right": otherBorders.right = style
        default: otherBorders.bottom = style
        }

        // Act
        let isEqual = borders == otherBorders

        // Assert
        #expect(!isEqual)
    }
}
