//
//  PDFTable+Subscripts.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 20.12.19.
//

import Foundation

extension PDFTable {

    // MARK: - Single cell accessor

    /**
     Accessor for a specific cell at the given position

     - parameter row: Index of row
     - parameter column: Index of column

     - returns: cell at given indicies
     */
    public subscript(row: Int, column: Int) -> PDFTableCell {
        return self.cells[row][column]
    }

    // MARK: - Single line of cells accessors

    /**
     Accessor for a specific row

     - parameter row: Index of row

     - returns: `PDFTableRow` with references to cells of this table
     */
    public subscript(row: Int) -> PDFTableRow {
        return PDFTableRow(cells: self.cells[row], of: self, at: row)
    }

    /**
     Accessor for a specific column

     - parameter column: Index of column

     - returns: `PDFTableColumn` with references to cells of this table
     */
    public subscript(column: Int) -> PDFTableColumn {
        return PDFTableColumn(cells: self.cells.map({ row in row[column] }), of: self, at: column)
    }

    // MARK: - Multiple rows accessors

    /**
     Accessors of rows in the given range.

     - parameter rows: Range of indicies

     - returns: `PDFTableRows` with references to rows
     */
    public subscript(rows range: ClosedRange<Int>) -> PDFTableRows {
        return self[rows: range.relative(to: cells)]
    }

    /**
     Accessors of rows in the given range.

     - parameter rows: Range of indicies

     - returns: `PDFTableRows` with references to rows
     */
    public subscript(rows range: PartialRangeFrom<Int>) -> PDFTableRows {
        return self[rows: range.relative(to: cells)]
    }

    /**
     Accessors of rows in the given range.

     - parameter rows: Range of indicies

     - returns: `PDFTableRows` with references to rows
     */
    public subscript(rows range: PartialRangeThrough<Int>) -> PDFTableRows {
        return self[rows: range.relative(to: cells)]
    }

    /**
     Accessors of rows in the given range.

     - parameter rows: Range of indicies

     - returns: `PDFTableRows` with references to rows
     */
    public subscript(rows range: PartialRangeUpTo<Int>) -> PDFTableRows {
        return self[rows: range.relative(to: cells)]
    }

    /**
     Accessors of rows in the given range.

     - parameter rows: Range of indicies

     - returns: `PDFTableRows` with references to rows
     */
    public subscript(rows range: Range<Int>) -> PDFTableRows {
        return PDFTableRows(
            rows: range
                .map({ (position: $0, cells: self.cells[$0]) })
                .map({ PDFTableRow.init(cells: $0.cells, of: self, at: $0.position) }),
            of: self,
            in: range)
    }

    // MARK: - Multiple columns accessors

    /**
     Accessors of columns in the given range.

     - parameter columns: Range of indicies

     - returns: `PDFTableColumns` with references to columns
     */
    public subscript(columns: ClosedRange<Int>) -> PDFTableColumns {
        return self[columns.relative(to: columns.relative(to: cells[0]))]
    }

    /**
     Accessors of columns in the given range.

     - parameter columns: Range of indicies

     - returns: `PDFTableColumns` with references to columns
     */
    public subscript(columns: PartialRangeFrom<Int>) -> PDFTableColumns {
        return self[columns.relative(to: columns.relative(to: cells[0]))]
    }

    /**
     Accessors of columns in the given range.

     - parameter columns: Range of indicies

     - returns: `PDFTableColumns` with references to columns
     */
    public subscript(columns: PartialRangeThrough<Int>) -> PDFTableColumns {
        return self[columns.relative(to: columns.relative(to: cells[0]))]
    }

    /**
     Accessors of columns in the given range.

     - parameter columns: Range of indicies

     - returns: `PDFTableColumns` with references to columns
     */
    public subscript(columns: PartialRangeUpTo<Int>) -> PDFTableColumns {
        return self[columns.relative(to: columns.relative(to: cells[0]))]
    }

    /**
     Accessors of columns in the given range.

     - parameter columns: Range of indicies

     - returns: `PDFTableColumns` with references to columns
     */
    public subscript(columns: Range<Int>) -> PDFTableColumns {
        return PDFTableColumns(
            columns: columns
                .map({ column in
                    (position: column, cells: self.cells.map({ $0[column] }))
                })
                .map({ PDFTableColumn.init(cells: $0.cells, of: self, at: $0.position) }),
            of: self,
            in: columns)
    }

    // MARK: - Section of cells accessors

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: Range<Int>, columns: ClosedRange<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: Range<Int>, columns: PartialRangeFrom<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: Range<Int>, columns: PartialRangeThrough<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: Range<Int>, columns: PartialRangeUpTo<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: ClosedRange<Int>, columns: Range<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: ClosedRange<Int>, columns: ClosedRange<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: ClosedRange<Int>, columns: PartialRangeFrom<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: ClosedRange<Int>, columns: PartialRangeThrough<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: ClosedRange<Int>, columns: PartialRangeUpTo<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: PartialRangeFrom<Int>, columns: Range<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: PartialRangeFrom<Int>, columns: ClosedRange<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: PartialRangeFrom<Int>, columns: PartialRangeFrom<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: PartialRangeFrom<Int>, columns: PartialRangeThrough<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: PartialRangeFrom<Int>, columns: PartialRangeUpTo<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: PartialRangeUpTo<Int>, columns: Range<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: PartialRangeUpTo<Int>, columns: ClosedRange<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: PartialRangeUpTo<Int>, columns: PartialRangeFrom<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: PartialRangeUpTo<Int>, columns: PartialRangeThrough<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: PartialRangeUpTo<Int>, columns: PartialRangeUpTo<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: Range<Int>, columns: Range<Int>) -> PDFTableSection {
        return PDFTableSection(cells: self.cells[rows].map({ Array($0[columns]) }), of: self, in: rows, and: columns)
    }
}
