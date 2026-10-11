//
//  PDFTableCellPositionHashableTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.16.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Testing
@testable import TPPDF

struct PDFTableCellPositionHashableTests {
    @Test func hashingPositionIsStableAndDistinguishesDifferentCoordinates() {
        // Arrange
        let position = PDFTableCellPosition(row: 1, column: 2)
        let otherPosition = PDFTableCellPosition(row: 4, column: 9)

        // Act
        let hash = position.hashValue
        let repeatedHash = position.hashValue
        let otherHash = otherPosition.hashValue

        // Assert
        #expect(hash == repeatedHash)
        #expect(hash != otherHash)
    }
}
