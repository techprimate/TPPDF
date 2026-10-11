//
//  PDFTableCellPositionTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.12.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Testing
@testable import TPPDF

struct PDFTableCellPositionTests {
    @Test func initializingWithCoordinatesPreservesRowAndColumn() {
        // Arrange
        let row = 2
        let column = 5

        // Act
        let position = PDFTableCellPosition(row: row, column: column)

        // Assert
        #expect(position.row == row)
        #expect(position.column == column)
    }
}
