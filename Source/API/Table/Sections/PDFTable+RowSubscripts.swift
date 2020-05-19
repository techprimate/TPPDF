//
//  PDFTable+SingleCellSubscripts.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 22.12.19.
//

import Foundation

extension PDFTable {

    /**
     Accessor for a specific row

     - parameter row: Index of row

     - returns: `PDFTableRow` with references to cells of this table
     */
    public subscript(row index: Int) -> PDFTableRow {
        get {
            PDFTableRow(cells: self.cells[index], of: self, at: index)
        }
        set {
            self.cells[index] = newValue.cells
        }
    }

    /**
     Accessors of rows in the given range.

     - parameter rows: Range of indicies

     - returns: `PDFTableRows` with references to rows
     */
    public subscript(rows range: ClosedRange<Int>) -> PDFTableRows {
        get {
            self[rows: range.relative(to: cells)]
        }
        set {
            self[rows: range.relative(to: cells)] = newValue
        }
    }

    /**
     Accessors of rows in the given range.

     - parameter rows: Range of indicies

     - returns: `PDFTableRows` with references to rows
     */
    public subscript(rows range: PartialRangeFrom<Int>) -> PDFTableRows {
        get {
            self[rows: range.relative(to: cells)]
        }
        set {
            self[rows: range.relative(to: cells)] = newValue
        }
    }

    /**
     Accessors of rows in the given range.

     - parameter rows: Range of indicies

     - returns: `PDFTableRows` with references to rows
     */
    public subscript(rows range: PartialRangeThrough<Int>) -> PDFTableRows {
        get {
            self[rows: range.relative(to: cells)]
        }
        set {
            self[rows: range.relative(to: cells)] = newValue
        }
    }

    /**
     Accessors of rows in the given range.

     - parameter rows: Range of indicies

     - returns: `PDFTableRows` with references to rows
     */
    public subscript(rows range: PartialRangeUpTo<Int>) -> PDFTableRows {
        get {
            self[rows: range.relative(to: cells)]
        }
        set {
            self[rows: range.relative(to: cells)] = newValue
        }
    }

    /**
     Accessors of rows in the given range.

     - parameter rows: Range of indicies

     - returns: `PDFTableRows` with references to rows
     */
    public subscript(rows range: Range<Int>) -> PDFTableRows {
        get {
            PDFTableRows(
                rows: range
                    .map({ (position: $0, cells: self.cells[$0]) })
                    .map({ PDFTableRow.init(cells: $0.cells, of: self, at: $0.position) }),
                of: self,
                in: range)
        }
        set {
            for (rowIdx, row) in range.enumerated() {
                self[row: row] = newValue.rows[rowIdx]
            }
        }
    }
}
