//
//  PDFTableTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.16.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Testing
@testable import TPPDF

struct PDFTableTests {
    @Test func initializingEmptyTableUsesDefaultStyleAndLayoutSettings() {
        // Arrange
        let expectedStyle = PDFTableStyleDefaults.simple

        // Act
        let table = PDFTable(rows: 0, columns: 0)

        // Assert
        #expect(table.style == expectedStyle)
        #expect(table.cells.isEmpty)
        #expect(table.widths.isEmpty)
        #expect(table.padding == 0)
        #expect(table.margin == 0)
        #expect(!table.showHeadersOnEveryPage)
    }

    @Test(arguments: [false, true], [false, true])
    func copyingTablePreservesPaginationSettings(splitCells: Bool, repeatHeaders: Bool) {
        // Arrange
        let table = PDFTable(rows: 2, columns: 2)
        table.shouldSplitCellsOnPageBreak = splitCells
        table.showHeadersOnEveryPage = repeatHeaders

        // Act
        let copy = table.copy

        // Assert
        #expect(copy !== table)
        #expect(copy.shouldSplitCellsOnPageBreak == splitCells)
        #expect(copy.showHeadersOnEveryPage == repeatHeaders)
    }

    @Test func settingStyleThroughCellSubscriptUpdatesStoredCell() {
        // Arrange
        let table = PDFTable(rows: 0, columns: 0)
        table.cells = [[PDFTableCell()]]
        let style = PDFTableCellStyle(colors: (fill: .green, text: .orange))

        // Act
        table[0, 0].style = style

        // Assert
        #expect(table.cells[0][0].style == style)
    }
}
