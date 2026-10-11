//
//  PDFTableMergeUtilTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 22.12.2019.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Testing
@testable import TPPDF

struct PDFTableMergeUtilTests {
    @Test func unmergedTableReturnsOneNodePerCellWithoutSpans() {
        // Arrange
        let table = makeTable()

        // Act
        let result = PDFTableMergeUtil.calculateMerged(table: table)

        // Assert
        #expect(result.count == 10)
        for row in 0..<10 {
            #expect(result[row].count == 10)
            for column in 0..<10 {
                let node = result[row][column]
                #expect(node.cell === table.cells[row][column])
                #expect(node.moreRowsSpan == 0)
                #expect(node.moreColumnsSpan == 0)
            }
        }
    }

    @Test func mergingEachRowReturnsOneNodePerRowSpanningAllColumns() {
        // Arrange
        let table = makeTable()
        for row in 0..<10 {
            table[row: row].merge()
        }

        // Act
        let result = PDFTableMergeUtil.calculateMerged(table: table)

        // Assert
        #expect(result.count == 10)
        for row in 0..<10 {
            #expect(result[row].count == 1)
            let node = result[row][0]
            #expect(node.cell === table.cells[row][0])
            #expect(node.moreRowsSpan == 0)
            #expect(node.moreColumnsSpan == 9)
        }
    }

    @Test func mergingEachColumnReturnsOneNodePerColumnSpanningAllRows() {
        // Arrange
        let table = makeTable()
        for column in 0..<10 {
            table[column: column].merge()
        }

        // Act
        let result = PDFTableMergeUtil.calculateMerged(table: table)

        // Assert
        #expect(result.count == 1)
        #expect(result[0].count == 10)
        for column in 0..<10 {
            let node = result[0][column]
            #expect(node.cell === table.cells[0][column])
            #expect(node.moreRowsSpan == 9)
            #expect(node.moreColumnsSpan == 0)
        }
    }

    @Test(arguments: [(0, 0), (0, 3), (3, 0)])
    func emptyDimensionsProduceNoNodes(rows: Int, columns: Int) {
        // Arrange
        let table = PDFTable(rows: rows, columns: columns)

        // Act
        let result = PDFTableMergeUtil.calculateMerged(table: table)

        // Assert
        #expect(result.isEmpty)
    }

    @Test(arguments: [(1, 1), (1, 3), (3, 1), (2, 3)])
    func mergingWholeTableProducesOneNodeWithBothSpans(rows: Int, columns: Int) throws {
        // Arrange
        let table = PDFTable(rows: rows, columns: columns)
        let cell = table[0, 0]
        table[rows: 0..<rows, columns: 0..<columns].merge(with: cell)

        // Act
        let result = PDFTableMergeUtil.calculateMerged(table: table)

        // Assert
        try #require(result.count == 1)
        try #require(result[0].count == 1)
        let node = result[0][0]
        #expect(node.cell === cell)
        #expect(node.position == PDFTableCellPosition(row: 0, column: 0))
        #expect(node.moreRowsSpan == rows - 1)
        #expect(node.moreColumnsSpan == columns - 1)
    }

    @Test func interiorRectanglePreservesUnmergedNeighborsAndOriginalPositions() throws {
        // Arrange
        let table = PDFTable(rows: 4, columns: 4)
        let cell = table[1, 1]
        table[rows: 1..<3, columns: 1..<3].merge(with: cell)
        let expectedPositions = [
            [(0, 0), (0, 1), (0, 2), (0, 3)],
            [(1, 0), (1, 1), (1, 3)],
            [(2, 0), (2, 3)],
            [(3, 0), (3, 1), (3, 2), (3, 3)],
        ]

        // Act
        let result = PDFTableMergeUtil.calculateMerged(table: table)

        // Assert
        try #require(result.count == 4)
        for (row, positions) in expectedPositions.enumerated() {
            try #require(result[row].count == positions.count)
            for (index, position) in positions.enumerated() {
                let node = result[row][index]
                let isMerged = position == (1, 1)
                #expect(node.position == PDFTableCellPosition(row: position.0, column: position.1))
                #expect(node.cell === table[position.0, position.1])
                #expect(node.moreRowsSpan == (isMerged ? 1 : 0))
                #expect(node.moreColumnsSpan == (isMerged ? 1 : 0))
            }
        }
    }

    private func makeTable() -> PDFTable {
        let table = PDFTable(rows: 10, columns: 10)
        for row in 0..<10 {
            for column in 0..<10 {
                table[row, column].content = "\(row),\(column)".asTableContent
            }
        }
        return table
    }
}
