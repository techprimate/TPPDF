//
//  PDFTableStyleDefaultsTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.13.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Testing
@testable import TPPDF

struct PDFTableStyleDefaultsTests {
    @Test func simpleStyleUsesExpectedHeadersOutlineAndAlternatingContent() {
        // Arrange
        let darkGray = Color(red: 59.0 / 255, green: 59.0 / 255, blue: 59.0 / 255, alpha: 1)
        let outline = PDFLineStyle(type: .full, color: .darkGray, width: 1)
        let rowHeader = PDFTableCellStyle(
            colors: (fill: .white, text: darkGray),
            borders: PDFTableCellBorders(bottom: PDFLineStyle(type: .full, color: .lightGray, width: 0.5)),
            font: Font.boldSystemFont(ofSize: 12)
        )
        let columnHeader = PDFTableCellStyle(
            colors: (fill: Color(red: 83.0 / 255, green: 171.0 / 255, blue: 104.0 / 255, alpha: 1), text: .white),
            font: Font.boldSystemFont(ofSize: 14)
        )
        let content = PDFTableCellStyle(
            colors: (fill: Color(red: 246.0 / 255, green: 246.0 / 255, blue: 246.0 / 255, alpha: 1), text: darkGray),
            font: Font.systemFont(ofSize: 14)
        )
        let alternatingContent = PDFTableCellStyle(
            colors: (fill: Color(red: 233.0 / 255, green: 233.0 / 255, blue: 233.0 / 255, alpha: 1), text: darkGray),
            font: Font.systemFont(ofSize: 14)
        )

        // Act
        let style = PDFTableStyleDefaults.simple

        // Assert
        #expect(style.rowHeaderCount == 1)
        #expect(style.columnHeaderCount == 1)
        #expect(style.footerCount == 0)
        #expect(style.outline == outline)
        #expect(style.rowHeaderStyle == rowHeader)
        #expect(style.columnHeaderStyle == columnHeader)
        #expect(style.contentStyle == content)
        #expect(style.alternatingContentStyle == alternatingContent)
    }
}
