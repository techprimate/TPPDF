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
