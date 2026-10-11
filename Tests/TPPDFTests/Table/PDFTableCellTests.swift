//
//  PDFTableCellTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.16.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Testing
@testable import TPPDF

struct PDFTableCellTests {
    @Test func initializingCellUsesNoContentOrStyleAndCenterAlignment() {
        // Arrange
        let expectedAlignment = PDFTableCellAlignment.center

        // Act
        let cell = PDFTableCell()

        // Assert
        #expect(cell.content == nil)
        #expect(cell.style == nil)
        #expect(cell.alignment == expectedAlignment)
    }

    @Test func initializingWithContentPreservesContent() throws {
        // Arrange
        let optionalContent = try PDFTableContent(content: "EXAMPLE")
        let content = try #require(optionalContent)

        // Act
        let cell = PDFTableCell(content: content)

        // Assert
        #expect(cell.content == content)
    }

    @Test func initializingWithAlignmentPreservesAlignment() {
        // Arrange
        let alignment = PDFTableCellAlignment.bottomRight

        // Act
        let cell = PDFTableCell(alignment: alignment)

        // Assert
        #expect(cell.alignment == alignment)
    }

    @Test func initializingWithStylePreservesStyle() {
        // Arrange
        let style = PDFTableCellStyle(colors: (fill: .blue, text: .green))

        // Act
        let cell = PDFTableCell(style: style)

        // Assert
        #expect(cell.style == style)
    }
}
