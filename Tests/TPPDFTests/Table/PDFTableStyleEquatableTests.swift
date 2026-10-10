//
//  PDFTableStyleEquatableTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.13.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Testing
@testable import TPPDF

struct PDFTableStyleEquatableTests {
    @Test func stylesWithSameValuesAreEqual() {
        // Arrange
        let style = makeStyle()
        let otherStyle = makeStyle()

        // Act
        let isEqual = style == otherStyle

        // Assert
        #expect(isEqual)
    }

    @Test(arguments: [
        "rowHeaderCount", "columnHeaderCount", "footerCount", "outline", "rowHeaderStyle",
        "columnHeaderStyle", "footerStyle", "contentStyle", "alternatingContentStyle",
    ])
    func changingAnyTableStyleValueMakesStylesUnequal(property: String) {
        // Arrange
        let style = makeStyle()
        let otherStyle = makeStyle()
        let cellStyle = PDFTableCellStyle(colors: (fill: .red, text: .blue), font: Font.systemFont(ofSize: 20))
        switch property {
        case "rowHeaderCount": otherStyle.rowHeaderCount = 1000
        case "columnHeaderCount": otherStyle.columnHeaderCount = 1000
        case "footerCount": otherStyle.footerCount = 1000
        case "outline": otherStyle.outline = PDFLineStyle(type: .dotted, color: .orange, width: 1)
        case "rowHeaderStyle": otherStyle.rowHeaderStyle = cellStyle
        case "columnHeaderStyle": otherStyle.columnHeaderStyle = cellStyle
        case "footerStyle": otherStyle.footerStyle = cellStyle
        case "contentStyle": otherStyle.contentStyle = cellStyle
        default: otherStyle.alternatingContentStyle = nil
        }

        // Act
        let isEqual = style == otherStyle

        // Assert
        #expect(!isEqual)
    }

    private func makeStyle() -> PDFTableStyle {
        PDFTableStyle(
            rowHeaderCount: 1, columnHeaderCount: 2, footerCount: 3, outline: .none,
            rowHeaderStyle: PDFTableCellStyle(), columnHeaderStyle: PDFTableCellStyle(),
            footerStyle: PDFTableCellStyle(), contentStyle: PDFTableCellStyle(),
            alternatingContentStyle: PDFTableCellStyle()
        )
    }
}
