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
    public subscript(row: Int, columns: Range<Int>) -> PDFTableSection {
        get {
            return self[row...row, columns.relative(to: cells[0])]
        }
        set {
            self[row...row, columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(row: Int, columns: ClosedRange<Int>) -> PDFTableSection {
        get {
            return self[row...row, columns.relative(to: cells[0])]
        }
        set {
            self[row...row, columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(row: Int, columns: PartialRangeFrom<Int>) -> PDFTableSection {
        get {
            return self[row...row, columns.relative(to: cells[0])]
        }
        set {
            self[row...row, columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(row: Int, columns: PartialRangeThrough<Int>) -> PDFTableSection {
        get {
            return self[row...row, columns.relative(to: cells[0])]
        }
        set {
            self[row...row, columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(row: Int, columns: PartialRangeUpTo<Int>) -> PDFTableSection {
        get {
            return self[row...row, columns.relative(to: cells[0])]
        }
        set {
            self[row...row, columns.relative(to: cells[0])] = newValue
        }
    }

    // MARK: - Range

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: Range<Int>, columns: ClosedRange<Int>) -> PDFTableSection {
        get {
            return self[rows.relative(to: cells), columns.relative(to: cells[0])]
        }
        set {
            self[rows.relative(to: cells), columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: Range<Int>, columns: PartialRangeFrom<Int>) -> PDFTableSection {
        get {
            return self[rows.relative(to: cells), columns.relative(to: cells[0])]
        }
        set {
            self[rows.relative(to: cells), columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: Range<Int>, columns: PartialRangeThrough<Int>) -> PDFTableSection {
        get {
            return self[rows.relative(to: cells), columns.relative(to: cells[0])]
        }
        set {
            self[rows.relative(to: cells), columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: Range<Int>, columns: PartialRangeUpTo<Int>) -> PDFTableSection {
        get {
            return self[rows.relative(to: cells), columns.relative(to: cells[0])]
        }
        set {
            self[rows.relative(to: cells), columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of column in the given rows

     - parameter rows: Range of indicies
     - parameter column: Single row index

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: Range<Int>, column: Int) -> PDFTableSection {
        get {
            return self[rows.relative(to: cells), column...column]
        }
        set {
            self[rows.relative(to: cells), column...column] = newValue
        }
    }

    // MARK: - Closed Range

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: ClosedRange<Int>, columns: Range<Int>) -> PDFTableSection {
        get {
            return self[rows.relative(to: cells), columns.relative(to: cells[0])]
        }
        set {
            self[rows.relative(to: cells), columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: ClosedRange<Int>, columns: ClosedRange<Int>) -> PDFTableSection {
        get {
            return self[rows.relative(to: cells), columns.relative(to: cells[0])]
        }
        set {
            self[rows.relative(to: cells), columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: ClosedRange<Int>, columns: PartialRangeFrom<Int>) -> PDFTableSection {
        get {
            return self[rows.relative(to: cells), columns.relative(to: cells[0])]
        }
        set {
            self[rows.relative(to: cells), columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: ClosedRange<Int>, columns: PartialRangeThrough<Int>) -> PDFTableSection {
        get {
            return self[rows.relative(to: cells), columns.relative(to: cells[0])]
        }
        set {
            self[rows.relative(to: cells), columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: ClosedRange<Int>, columns: PartialRangeUpTo<Int>) -> PDFTableSection {
        get {
            return self[rows.relative(to: cells), columns.relative(to: cells[0])]
        }
        set {
            self[rows.relative(to: cells), columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of column in the given rows

     - parameter rows: Range of indicies
     - parameter column: Single row index

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: ClosedRange<Int>, column: Int) -> PDFTableSection {
        get {
            return self[rows.relative(to: cells), column...column]
        }
        set {
            self[rows.relative(to: cells), column...column] = newValue
        }
    }

    // MARK: - Partial Range From

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: PartialRangeFrom<Int>, columns: Range<Int>) -> PDFTableSection {
        get {
            return self[rows.relative(to: cells), columns.relative(to: cells[0])]
        }
        set {
            self[rows.relative(to: cells), columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: PartialRangeFrom<Int>, columns: ClosedRange<Int>) -> PDFTableSection {
        get {
            return self[rows.relative(to: cells), columns.relative(to: cells[0])]
        }
        set {
            self[rows.relative(to: cells), columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: PartialRangeFrom<Int>, columns: PartialRangeFrom<Int>) -> PDFTableSection {
        get {
            return self[rows.relative(to: cells), columns.relative(to: cells[0])]
        }
        set {
            self[rows.relative(to: cells), columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: PartialRangeFrom<Int>, columns: PartialRangeThrough<Int>) -> PDFTableSection {
        get {
            return self[rows.relative(to: cells), columns.relative(to: cells[0])]
        }
        set {
            self[rows.relative(to: cells), columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: PartialRangeFrom<Int>, columns: PartialRangeUpTo<Int>) -> PDFTableSection {
        get {
            return self[rows.relative(to: cells), columns.relative(to: cells[0])]
        }
        set {
            self[rows.relative(to: cells), columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of column in the given rows

     - parameter rows: Range of indicies
     - parameter column: Single row index

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: PartialRangeFrom<Int>, column: Int) -> PDFTableSection {
        get {
            return self[rows.relative(to: cells), column...column]
        }
        set {
            self[rows.relative(to: cells), column...column] = newValue
        }
    }

    // MARK: - Partial Range Up To

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: PartialRangeUpTo<Int>, columns: Range<Int>) -> PDFTableSection {
        get {
            return self[rows.relative(to: cells), columns.relative(to: cells[0])]
        }
        set {
            self[rows.relative(to: cells), columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: PartialRangeUpTo<Int>, columns: ClosedRange<Int>) -> PDFTableSection {
        get {
            return self[rows.relative(to: cells), columns.relative(to: cells[0])]
        }
        set {
            self[rows.relative(to: cells), columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: PartialRangeUpTo<Int>, columns: PartialRangeFrom<Int>) -> PDFTableSection {
        get {
            return self[rows.relative(to: cells), columns.relative(to: cells[0])]
        }
        set {
            self[rows.relative(to: cells), columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: PartialRangeUpTo<Int>, columns: PartialRangeThrough<Int>) -> PDFTableSection {
        get {
            return self[rows.relative(to: cells), columns.relative(to: cells[0])]
        }
        set {
            self[rows.relative(to: cells), columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: PartialRangeUpTo<Int>, columns: PartialRangeUpTo<Int>) -> PDFTableSection {
        get {
            return self[rows.relative(to: cells), columns.relative(to: cells[0])]
        }
        set {
            self[rows.relative(to: cells), columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     Accessors of column in the given rows

     - parameter rows: Range of indicies
     - parameter column: Single row index

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: PartialRangeUpTo<Int>, column: Int) -> PDFTableSection {
        get {
            return self[rows.relative(to: cells), column...column]
        }
        set {
            self[rows.relative(to: cells), column...column] = newValue
        }
    }

    /**
     Accessors of cells in the given rows and columns range.

     - parameter rows: Range of indicies
     - parameter columns: Range of indicies

     - returns: `PDFTableSection` with references to cells
     */
    public subscript(rows: Range<Int>, columns: Range<Int>) -> PDFTableSection {
        get {
            return PDFTableSection(cells: self.cells[rows].map({ Array($0[columns]) }), of: self, in: rows, and: columns)
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
