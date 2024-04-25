//
//  PDFTable+RowSubscripts.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 22.12.19.
//

import Foundation

public extension PDFTable {
    /**
     * Accessor for a specific row
     *
     * - Parameter row: Index of row
     *
     * - Returns: ``PDFTableRow`` with references to cells of this table
     */
    subscript(row index: Int) -> PDFTableRow {
        get {
            PDFTableRow(cells: cells[index], of: self, at: index)
        }
        set {
            cells[index] = newValue.cells
        }
    }

    /**
     * Accessor for multiple rows in the given range `rows`
     *
     * - Parameter rows: Range of indicies
     *
     * - Returns: ``PDFTableRows`` with references to rows
     */
    subscript(rows range: ClosedRange<Int>) -> PDFTableRows {
        get {
            self[rows: range.relative(to: cells)]
        }
        set {
            self[rows: range.relative(to: cells)] = newValue
        }
    }

    /**
     * Accessor for multiple rows in the given range `rows`
     *
     * - Parameter rows: Range of indicies
     *
     * - Returns: ``PDFTableRows`` with references to rows
     */
    subscript(rows range: PartialRangeFrom<Int>) -> PDFTableRows {
        get {
            self[rows: range.relative(to: cells)]
        }
        set {
            self[rows: range.relative(to: cells)] = newValue
        }
    }

    /**
     * Accessor for multiple rows in the given range `rows`
     *
     * - Parameter rows: Range of indicies
     *
     * - Returns: ``PDFTableRows`` with references to rows
     */
    subscript(rows range: PartialRangeThrough<Int>) -> PDFTableRows {
        get {
            self[rows: range.relative(to: cells)]
        }
        set {
            self[rows: range.relative(to: cells)] = newValue
        }
    }

    /**
     * Accessor for multiple rows in the given range `rows`
     *
     * - Parameter rows: Range of indicies
     *
     * - Returns: ``PDFTableRows`` with references to rows
     */
    subscript(rows range: PartialRangeUpTo<Int>) -> PDFTableRows {
        get {
            self[rows: range.relative(to: cells)]
        }
        set {
            self[rows: range.relative(to: cells)] = newValue
        }
    }

    /**
     * Accessor for multiple rows in the given range `rows`
     *
     * - Parameter rows: Range of indicies
     *
     * - Returns: ``PDFTableRows`` with references to rows
     */
    subscript(rows range: Range<Int>) -> PDFTableRows {
        get {
            PDFTableRows(
                rows: range
                    .map { (position: $0, cells: self.cells[$0]) }
                    .map { PDFTableRow(cells: $0.cells, of: self, at: $0.position) },
                of: self,
                in: range
            )
        }
        set {
            for (rowIdx, row) in range.enumerated() {
                self[row: row] = newValue.rows[rowIdx]
            }
        }
    }
}
