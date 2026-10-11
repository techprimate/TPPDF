//
//  PDFTableRowTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 23.09.2020.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Testing
@testable import TPPDF

struct PDFTableRowTests {
    @Test func settingAllRowsAlignmentAppliesSameAlignmentToEveryRow() {
        // Arrange
        let table = PDFTable(rows: 3, columns: 3)
        let alignment: [PDFTableCellAlignment] = [.left, .center, .right]

        // Act
        table.rows.allRowsAlignment = alignment
        let result = table.rows.alignment

        // Assert
        #expect(result == [alignment, alignment, alignment])
    }
}
