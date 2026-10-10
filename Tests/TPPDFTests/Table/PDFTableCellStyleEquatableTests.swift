//
//  PDFTableCellStyleEquatableTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.16.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Testing
@testable import TPPDF

struct PDFTableCellStyleEquatableTests {
    @Test func defaultCellStylesAreEqual() {
        // Arrange
        let style = PDFTableCellStyle()
        let otherStyle = PDFTableCellStyle()

        // Act
        let isEqual = style == otherStyle

        // Assert
        #expect(isEqual)
    }

    @Test(arguments: ["colors", "borders", "font"])
    func changingCellStyleValuesMakesStylesUnequal(property: String) {
        // Arrange
        let style = PDFTableCellStyle()
        let otherStyle: PDFTableCellStyle
        switch property {
        case "colors": otherStyle = PDFTableCellStyle(colors: (fill: .red, text: .blue))
        case "borders": otherStyle = PDFTableCellStyle(borders: PDFTableCellBorders(left: PDFLineStyle(type: .dotted)))
        default: otherStyle = PDFTableCellStyle(font: Font.boldSystemFont(ofSize: 10))
        }

        // Act
        let isEqual = style == otherStyle

        // Assert
        #expect(!isEqual)
    }
}
