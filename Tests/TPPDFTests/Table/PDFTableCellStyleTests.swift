//
//  PDFTableCellStyleTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.16.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Testing
@testable import TPPDF

struct PDFTableCellStyleTests {
    @Test func initializingWithoutArgumentsUsesDefaultColorsBordersAndFont() {
        // Arrange
        let expectedBorders = PDFTableCellBorders()
        let expectedFont = Font.systemFont(ofSize: PDFConstants.defaultFontSize)

        // Act
        let style = PDFTableCellStyle()

        // Assert
        #expect(style.colors.fill == .clear)
        #expect(style.colors.text == .black)
        #expect(style.borders == expectedBorders)
        #expect(style.font == expectedFont)
    }

    @Test func initializingWithColorsPreservesFillAndTextColors() {
        // Arrange
        let colors = (fill: Color.orange, text: Color.green)

        // Act
        let style = PDFTableCellStyle(colors: colors)

        // Assert
        #expect(style.colors.fill == colors.fill)
        #expect(style.colors.text == colors.text)
    }

    @Test func initializingWithBordersPreservesBorders() {
        // Arrange
        let borders = PDFTableCellBorders(left: PDFLineStyle(type: .dotted, color: .purple, width: 15))

        // Act
        let style = PDFTableCellStyle(borders: borders)

        // Assert
        #expect(style.borders == borders)
    }

    @Test func initializingWithFontPreservesFont() {
        // Arrange
        let font = Font.systemFont(ofSize: 25)

        // Act
        let style = PDFTableCellStyle(font: font)

        // Assert
        #expect(style.font == font)
    }
}
