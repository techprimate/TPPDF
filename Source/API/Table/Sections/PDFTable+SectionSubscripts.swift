//
//  PDFTable+Subscripts.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 20.12.19.
//

// swiftlint:disable file_length

import Foundation

extension PDFTable {

    // MARK: - Single Row

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows row: Int, columns columns: Range<Int>) -> PDFTableSection {
        get {
            self[rows: row...row, columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: row...row, columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows row: Int, columns columns: ClosedRange<Int>) -> PDFTableSection {
        get {
            self[rows: row...row, columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: row...row, columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows row: Int, columns columns: PartialRangeFrom<Int>) -> PDFTableSection {
        get {
            self[rows: row...row, columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: row...row, columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows row: Int, columns columns: PartialRangeThrough<Int>) -> PDFTableSection {
        get {
            self[rows: row...row, columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: row...row, columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows row: Int, columns columns: PartialRangeUpTo<Int>) -> PDFTableSection {
        get {
            self[rows: row...row, columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: row...row, columns: columns.relative(to: cells[0])] = newValue
        }
    }

    // MARK: - Range

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows rows: Range<Int>, columns columns: ClosedRange<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows rows: Range<Int>, columns columns: PartialRangeFrom<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows rows: Range<Int>, columns columns: PartialRangeThrough<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows rows: Range<Int>, columns columns: PartialRangeUpTo<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of column in the given rows

     - parameter rows: Range of indicies
     - parameter column: Single row index

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows rows: Range<Int>, column column: Int) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: column...column]
        }
        set {
            self[rows: rows.relative(to: cells), columns: column...column] = newValue
        }
    }

    // MARK: - Closed Range

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows rows: ClosedRange<Int>, columns columns: Range<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows rows: ClosedRange<Int>, columns columns: ClosedRange<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows rows: ClosedRange<Int>, columns columns: PartialRangeFrom<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows rows: ClosedRange<Int>, columns columns: PartialRangeThrough<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows rows: ClosedRange<Int>, columns columns: PartialRangeUpTo<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of column in the given rows

     - parameter rows: Range of indicies
     - parameter column: Single row index

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows rows: ClosedRange<Int>, column column: Int) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: column...column]
        }
        set {
            self[rows: rows.relative(to: cells), columns: column...column] = newValue
        }
    }

    // MARK: - Partial Range From

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows rows: PartialRangeFrom<Int>, columns columns: Range<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows rows: PartialRangeFrom<Int>, columns columns: ClosedRange<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows rows: PartialRangeFrom<Int>, columns columns: PartialRangeFrom<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows rows: PartialRangeFrom<Int>, columns columns: PartialRangeThrough<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows rows: PartialRangeFrom<Int>, columns columns: PartialRangeUpTo<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of column in the given rows

     - parameter rows: Range of indicies
     - parameter column: Single row index

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows rows: PartialRangeFrom<Int>, column column: Int) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: column...column]
        }
        set {
            self[rows: rows.relative(to: cells), columns: column...column] = newValue
        }
    }

    // MARK: - Partial Range Up To

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows rows: PartialRangeUpTo<Int>, columns columns: Range<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows rows: PartialRangeUpTo<Int>, columns columns: ClosedRange<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows rows: PartialRangeUpTo<Int>, columns columns: PartialRangeFrom<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows rows: PartialRangeUpTo<Int>, columns columns: PartialRangeThrough<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows rows: PartialRangeUpTo<Int>, columns columns: PartialRangeUpTo<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of column in the given rows

     - parameter rows: Range of indicies
     - parameter column: Single row index

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows rows: PartialRangeUpTo<Int>, column column: Int) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: column...column]
        }
        set {
            self[rows: rows.relative(to: cells), columns: column...column] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows rows: Range<Int>, columns columns: Range<Int>) -> PDFTableSection {
        get {
            PDFTableSection(cells: self.cells[rows].map({ Array($0[columns]) }), of: self, in: rows, and: columns)
        }
        set {
            for (rowIdx, row) in rows.enumerated() {
                for (colIdx, column) in columns.enumerated() {
                    self.cells[row][column] = newValue.cells[rowIdx][colIdx]
                }
            }
        }
    }
}
