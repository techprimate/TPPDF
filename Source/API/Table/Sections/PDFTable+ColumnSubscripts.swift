//
//  PDFTable+Subscripts.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 20.12.19.
//

import Foundation

extension PDFTable {

    /**
     Accessor for a specific column

     - parameter column: Index of column

     - returns: `PDFTableColumn` with references to cells of this table
     */
    public subscript(column index: Int) -> PDFTableColumn {
        get {
            PDFTableColumn(cells: self.cells.map({ row in row[index] }), of: self, at: index)
        }
        set {
            for idx in self.cells.indices {
                self.cells[idx][index] = newValue.cells[idx]
            }
        }
    }

    /**
     Accessors of columns in the given range.

     - parameter columns: Range of indicies

     - returns: `PDFTableColumns` with references to columns
     */
    public subscript(columns range: ClosedRange<Int>) -> PDFTableColumns {
        get {
            self[columns: range.relative(to: cells[0])]
        }
        set {
            self[columns: range.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of columns in the given range.

     - parameter columns: Range of indicies

     - returns: `PDFTableColumns` with references to columns
     */
    public subscript(columns range: PartialRangeFrom<Int>) -> PDFTableColumns {
        get {
            self[columns: range.relative(to: cells[0])]
        }
        set {
            self[columns: range.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of columns in the given range.

     - parameter columns: Range of indicies

     - returns: `PDFTableColumns` with references to columns
     */
    public subscript(columns range: PartialRangeThrough<Int>) -> PDFTableColumns {
        get {
            self[columns: range.relative(to: cells[0])]
        }
        set {
            self[columns: range.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of columns in the given range.

     - parameter columns: Range of indicies

     - returns: `PDFTableColumns` with references to columns
     */
    public subscript(columns range: PartialRangeUpTo<Int>) -> PDFTableColumns {
        get {
            self[columns: range.relative(to: cells[0])]
        }
        set {
            self[columns: range.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of columns in the given range.

     - parameter columns: Range of indicies

     - returns: `PDFTableColumns` with references to columns
     */
    public subscript(columns range: Range<Int>) -> PDFTableColumns {
        get {
            PDFTableColumns(
                columns: range
                    .map({ column in
                        (position: column, cells: self.cells.map({ $0[column] }))
                    })
                    .map({ PDFTableColumn.init(cells: $0.cells, of: self, at: $0.position) }),
                of: self,
                in: range)
        }
        set {
            for (colIdx, column) in range.enumerated() {
                self[column: column] = newValue.columns[colIdx]
            }
        }
    }
}
