//
//  PDFTable+SingleCellSubscripts.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 22.12.19.
//

import Foundation

extension PDFTable {

    /**
     Accessor for a specific cell at the given position

     - parameter row: Index of row
     - parameter column: Index of column

     - returns: cell at given indicies
     */
    public subscript(position position: PDFTableCellPosition) -> PDFTableCell {
        get {
            self[position.row, position.column]
        }
        set {
            self[position.row, position.column] = newValue
        }
    }

    /**
     Accessor for a specific cell at the given position

     - parameter row: Index of row
     - parameter column: Index of column

     - returns: cell at given indicies
     */
    public subscript(row: Int, column: Int) -> PDFTableCell {
        get {
            self.cells[row][column]
        }
        set {
            self.cells[row][column] = newValue
        }
    }
}
