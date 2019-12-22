//
//  PDFTableMergeUtil.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 22.12.19.
//

import Foundation

internal enum PDFTableMergeUtil {

    internal static func calculateMerged(table: PDFTable) -> [[PDFTableNode]] {
        guard table.size.rows > 0 && table.size.columns > 0 else {
            return []
        }
        var found = table.cells.map({ $0.map({ _ in false }) })

        var rows: [[PDFTableNode]] = []
        // Iterate all rows
        for (rowIdx, row) in table.cells.enumerated() {
            var rowNodes: [PDFTableNode] = []

            for (colIdx, cell) in row.enumerated() where !found[rowIdx][colIdx] {
                let node = PDFTableNode(cell: cell, position: PDFTableCellPosition(row: rowIdx, column: colIdx))
                found[rowIdx][colIdx] = true
                for adjacentColumnIdx in (colIdx + 1)..<table.size.columns {
                    guard row[adjacentColumnIdx] === cell else {
                        break
                    }
                    found[rowIdx][adjacentColumnIdx] = true
                    node.moreColumnsSpan += 1
                }
                for adjacentRowIdx in (rowIdx + 1)..<table.size.rows {
                    // Cell underneath current cell in next row
                    guard table.cells[adjacentRowIdx][colIdx] === cell else {
                        break
                    }
                    // Check if all statisfy identical
                    guard table.cells[adjacentRowIdx][0...node.moreColumnsSpan].allSatisfy({ $0 === cell }) else {
                        break
                    }
                    node.moreRowsSpan += 1
                    for columnIdxInAdjacentRow in colIdx..<(colIdx + node.moreColumnsSpan) {
                        found[adjacentRowIdx][columnIdxInAdjacentRow] = true
                    }
                }
                rowNodes.append(node)
            }
            rows.append(rowNodes)
        }
        return rows
    }
}
