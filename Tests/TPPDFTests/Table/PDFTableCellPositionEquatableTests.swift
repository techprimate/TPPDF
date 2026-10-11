//
//  PDFTableCellPositionEquatableTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.16.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Testing
@testable import TPPDF

struct PDFTableCellPositionEquatableTests {
    @Test(arguments: [(1, 2, true), (2, 2, false), (1, 3, false)])
    func equalityDependsOnBothCoordinates(row: Int, column: Int, expectedEquality: Bool) {
        // Arrange
        let position = PDFTableCellPosition(row: 1, column: 2)
        let otherPosition = PDFTableCellPosition(row: row, column: column)

        // Act
        let isEqual = position == otherPosition

        // Assert
        #expect(isEqual == expectedEquality)
    }
}
