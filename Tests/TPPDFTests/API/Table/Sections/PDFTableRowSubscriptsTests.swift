//
//  PDFTableRowSubscriptsTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 23.09.2020.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Testing
@testable import TPPDF

struct PDFTableRowSubscriptsTests {
    @Test func rowSubscriptReturnsCellsAtRequestedRowIndex() {
        // Arrange
        let table = PDFTable(rows: 3, columns: 3)
        let expectedCells = table.cells[1]

        // Act
        let cells = table[row: 1].cells

        // Assert
        #expect(cells == expectedCells)
    }
}
