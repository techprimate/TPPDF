//
//  PDFTableStyleTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.13.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Testing
@testable import TPPDF

struct PDFTableStyleTests {
    @Test func initializingWithoutArgumentsUsesDefaultCountsAndStyles() {
        // Arrange
        let expectedOutline = PDFLineStyle()
        let expectedCellStyle = PDFTableCellStyle()

        // Act
        let style = PDFTableStyle()

        // Assert
        #expect(style.rowHeaderCount == 1)
        #expect(style.columnHeaderCount == 1)
        #expect(style.footerCount == 1)
        #expect(style.outline == expectedOutline)
        #expect(style.rowHeaderStyle == expectedCellStyle)
        #expect(style.columnHeaderStyle == expectedCellStyle)
        #expect(style.footerStyle == expectedCellStyle)
        #expect(style.contentStyle == expectedCellStyle)
        #expect(style.alternatingContentStyle == nil)
    }

    @Test func initializingWithValuesPreservesCountsAndEachCellStyle() {
        // Arrange
        let outline = PDFLineStyle(type: .dashed, color: .orange, width: 1.25)
        let rowHeader = PDFTableCellStyle(colors: (fill: .blue, text: .green), font: Font.systemFont(ofSize: 10))
        let columnHeader = PDFTableCellStyle(colors: (fill: .black, text: .green), font: Font.systemFont(ofSize: 12))
        let footer = PDFTableCellStyle(colors: (fill: .purple, text: .green), font: Font.systemFont(ofSize: 15))
        let content = PDFTableCellStyle(colors: (fill: .blue, text: .orange), font: Font.systemFont(ofSize: 10))
        let alternatingContent = PDFTableCellStyle(colors: (fill: .red, text: .green), font: Font.systemFont(ofSize: 15))

        // Act
        let style = PDFTableStyle(
            rowHeaderCount: 4, columnHeaderCount: 4, footerCount: 4, outline: outline,
            rowHeaderStyle: rowHeader, columnHeaderStyle: columnHeader, footerStyle: footer,
            contentStyle: content, alternatingContentStyle: alternatingContent
        )

        // Assert
        #expect(style.rowHeaderCount == 4)
        #expect(style.columnHeaderCount == 4)
        #expect(style.footerCount == 4)
        #expect(style.outline == outline)
        #expect(style.rowHeaderStyle == rowHeader)
        #expect(style.columnHeaderStyle == columnHeader)
        #expect(style.footerStyle == footer)
        #expect(style.contentStyle == content)
        #expect(style.alternatingContentStyle == alternatingContent)
    }

    @Test func copyingCreatesDistinctStyleWithAllValuesPreserved() {
        // Arrange
        let style = PDFTableStyle(
            rowHeaderCount: 4, columnHeaderCount: 4, footerCount: 4,
            outline: PDFLineStyle(type: .dashed, color: .orange, width: 1.25),
            rowHeaderStyle: PDFTableCellStyle(colors: (fill: .blue, text: .green), font: Font.systemFont(ofSize: 10)),
            columnHeaderStyle: PDFTableCellStyle(colors: (fill: .black, text: .green), font: Font.systemFont(ofSize: 12)),
            footerStyle: PDFTableCellStyle(colors: (fill: .purple, text: .green), font: Font.systemFont(ofSize: 15)),
            contentStyle: PDFTableCellStyle(colors: (fill: .blue, text: .orange), font: Font.systemFont(ofSize: 10)),
            alternatingContentStyle: PDFTableCellStyle(colors: (fill: .red, text: .green), font: Font.systemFont(ofSize: 15))
        )

        // Act
        let copy = style.copy()

        // Assert
        #expect(copy !== style)
        #expect(copy.rowHeaderCount == style.rowHeaderCount)
        #expect(copy.columnHeaderCount == style.columnHeaderCount)
        #expect(copy.footerCount == style.footerCount)
        #expect(copy.outline == style.outline)
        #expect(copy.rowHeaderStyle == style.rowHeaderStyle)
        #expect(copy.columnHeaderStyle == style.columnHeaderStyle)
        #expect(copy.footerStyle == style.footerStyle)
        #expect(copy.contentStyle == style.contentStyle)
        #expect(copy.alternatingContentStyle == style.alternatingContentStyle)
    }
}
