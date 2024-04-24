//
//  PDFTable+CellSubscripts.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 22.12.19.
//

import Foundation

public extension PDFTable {
    /**
     * Accessor for a specific ``PDFTableCell`` at the given position
     *
     * - Parameter position: ``PDFTableCellPosition`` with row and column index
     *
     * - Returns: ``PDFTableCell`` at the given position
     */
    subscript(position position: PDFTableCellPosition) -> PDFTableCell {
        get {
            self[position.row, position.column]
        }
        set {
            self[position.row, position.column] = newValue
        }
    }

    /**
     * Accessor for a specific cell at the given position
     *
     * - Parameter row: Index of row
     * - Parameter column: Index of column
     *
     * - Returns: ``PDFTableCell``at the given position
     */
    subscript(row: Int, column: Int) -> PDFTableCell {
        get {
            cells[row][column]
        }
        set {
            cells[row][column] = newValue
        }
    }
}
