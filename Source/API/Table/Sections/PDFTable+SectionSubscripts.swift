//
//  PDFTable+SectionSubscripts.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 20.12.19.
//

// swiftlint:disable file_length

import Foundation

public extension PDFTable {
    // MARK: - Single Row

    /**
     * Accessors to the cells in the section defined by given ranges `rows` and `columns`
     *
     * - Parameter rows: Range of indicies
     * - Parameter columns: Range of indicies
     *
     * - Returns: ``PDFTableSection`` with references to cells
     */
    subscript(rows row: Int, columns columns: Range<Int>) -> PDFTableSection {
        get {
            self[rows: row...row, columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: row...row, columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     * Accessors to the cells in the section defined by given ranges `rows` and `columns`
     *
     * - Parameter rows: Range of indicies
     * - Parameter columns: Range of indicies
     *
     * - Returns: ``PDFTableSection`` with references to cells
     */
    subscript(rows row: Int, columns columns: ClosedRange<Int>) -> PDFTableSection {
        get {
            self[rows: row...row, columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: row...row, columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     * Accessors to the cells in the section defined by given ranges `rows` and `columns`
     *
     * - Parameter rows: Range of indicies
     * - Parameter columns: Range of indicies
     *
     * - Returns: ``PDFTableSection`` with references to cells
     */
    subscript(rows row: Int, columns columns: PartialRangeFrom<Int>) -> PDFTableSection {
        get {
            self[rows: row...row, columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: row...row, columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     * Accessors to the cells in the section defined by given ranges `rows` and `columns`
     *
     * - Parameter rows: Range of indicies
     * - Parameter columns: Range of indicies
     *
     * - Returns: ``PDFTableSection`` with references to cells
     */
    subscript(rows row: Int, columns columns: PartialRangeThrough<Int>) -> PDFTableSection {
        get {
            self[rows: row...row, columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: row...row, columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     * Accessors to the cells in the section defined by given ranges `rows` and `columns`
     *
     * - Parameter rows: Range of indicies
     * - Parameter columns: Range of indicies
     *
     * - Returns: ``PDFTableSection`` with references to cells
     */
    subscript(rows row: Int, columns columns: PartialRangeUpTo<Int>) -> PDFTableSection {
        get {
            self[rows: row...row, columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: row...row, columns: columns.relative(to: cells[0])] = newValue
        }
    }

    // MARK: - Range

    /**
     * Accessors to the cells in the section defined by given ranges `rows` and `columns`
     *
     * - Parameter rows: Range of indicies
     * - Parameter columns: Range of indicies
     *
     * - Returns: ``PDFTableSection`` with references to cells
     */
    subscript(rows rows: Range<Int>, columns columns: ClosedRange<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     * Accessors to the cells in the section defined by given ranges `rows` and `columns`
     *
     * - Parameter rows: Range of indicies
     * - Parameter columns: Range of indicies
     *
     * - Returns: ``PDFTableSection`` with references to cells
     */
    subscript(rows rows: Range<Int>, columns columns: PartialRangeFrom<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     * Accessors to the cells in the section defined by given ranges `rows` and `columns`
     *
     * - Parameter rows: Range of indicies
     * - Parameter columns: Range of indicies
     *
     * - Returns: ``PDFTableSection`` with references to cells
     */
    subscript(rows rows: Range<Int>, columns columns: PartialRangeThrough<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     * Accessors to the cells in the section defined by given ranges `rows` and `columns`
     *
     * - Parameter rows: Range of indicies
     * - Parameter columns: Range of indicies
     *
     * - Returns: ``PDFTableSection`` with references to cells
     */
    subscript(rows rows: Range<Int>, columns columns: PartialRangeUpTo<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     * Accessors to the cells in the section defined by given ranges `rows` and `columns`
     *
     * - Parameter rows: Range of indicies
     * - Parameter columns: Range of indicies
     *
     * - Returns: ``PDFTableSection`` with references to cells
     */
    subscript(rows rows: Range<Int>, column column: Int) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: column...column]
        }
        set {
            self[rows: rows.relative(to: cells), columns: column...column] = newValue
        }
    }

    // MARK: - Closed Range

    /**
     * Accessors to the cells in the section defined by given ranges `rows` and `columns`
     *
     * - Parameter rows: Range of indicies
     * - Parameter columns: Range of indicies
     *
     * - Returns: ``PDFTableSection`` with references to cells
     */
    subscript(rows rows: ClosedRange<Int>, columns columns: Range<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     * Accessors to the cells in the section defined by given ranges `rows` and `columns`
     *
     * - Parameter rows: Range of indicies
     * - Parameter columns: Range of indicies
     *
     * - Returns: ``PDFTableSection`` with references to cells
     */
    subscript(rows rows: ClosedRange<Int>, columns columns: ClosedRange<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     * Accessors to the cells in the section defined by given ranges `rows` and `columns`
     *
     * - Parameter rows: Range of indicies
     * - Parameter columns: Range of indicies
     *
     * - Returns: ``PDFTableSection`` with references to cells
     */
    subscript(rows rows: ClosedRange<Int>, columns columns: PartialRangeFrom<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     * Accessors to the cells in the section defined by given ranges `rows` and `columns`
     *
     * - Parameter rows: Range of indicies
     * - Parameter columns: Range of indicies
     *
     * - Returns: ``PDFTableSection`` with references to cells
     */
    subscript(rows rows: ClosedRange<Int>, columns columns: PartialRangeThrough<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     * Accessors to the cells in the section defined by given ranges `rows` and `columns`
     *
     * - Parameter rows: Range of indicies
     * - Parameter columns: Range of indicies
     *
     * - Returns: ``PDFTableSection`` with references to cells
     */
    subscript(rows rows: ClosedRange<Int>, columns columns: PartialRangeUpTo<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     * Accessors to the cells in the section defined by given ranges `rows` and `columns`
     *
     * - Parameter rows: Range of indicies
     * - Parameter columns: Range of indicies
     *
     * - Returns: ``PDFTableSection`` with references to cells
     */
    subscript(rows rows: ClosedRange<Int>, column column: Int) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: column...column]
        }
        set {
            self[rows: rows.relative(to: cells), columns: column...column] = newValue
        }
    }

    // MARK: - Partial Range From

    /**
     * Accessors to the cells in the section defined by given ranges `rows` and `columns`
     *
     * - Parameter rows: Range of indicies
     * - Parameter columns: Range of indicies
     *
     * - Returns: ``PDFTableSection`` with references to cells
     */
    subscript(rows rows: PartialRangeFrom<Int>, columns columns: Range<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     * Accessors to the cells in the section defined by given ranges `rows` and `columns`
     *
     * - Parameter rows: Range of indicies
     * - Parameter columns: Range of indicies
     *
     * - Returns: ``PDFTableSection`` with references to cells
     */
    subscript(rows rows: PartialRangeFrom<Int>, columns columns: ClosedRange<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     * Accessors to the cells in the section defined by given ranges `rows` and `columns`
     *
     * - Parameter rows: Range of indicies
     * - Parameter columns: Range of indicies
     *
     * - Returns: ``PDFTableSection`` with references to cells
     */
    subscript(rows rows: PartialRangeFrom<Int>, columns columns: PartialRangeFrom<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     * Accessors to the cells in the section defined by given ranges `rows` and `columns`
     *
     * - Parameter rows: Range of indicies
     * - Parameter columns: Range of indicies
     *
     * - Returns: ``PDFTableSection`` with references to cells
     */
    subscript(rows rows: PartialRangeFrom<Int>, columns columns: PartialRangeThrough<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     * Accessors to the cells in the section defined by given ranges `rows` and `columns`
     *
     * - Parameter rows: Range of indicies
     * - Parameter columns: Range of indicies
     *
     * - Returns: ``PDFTableSection`` with references to cells
     */
    subscript(rows rows: PartialRangeFrom<Int>, columns columns: PartialRangeUpTo<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     * Accessors to the cells in the section defined by given ranges `rows` and `columns`
     *
     * - Parameter rows: Range of indicies
     * - Parameter columns: Range of indicies
     *
     * - Returns: ``PDFTableSection`` with references to cells
     */
    subscript(rows rows: PartialRangeFrom<Int>, column column: Int) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: column...column]
        }
        set {
            self[rows: rows.relative(to: cells), columns: column...column] = newValue
        }
    }

    // MARK: - Partial Range Up To

    /**
     * Accessors to the cells in the section defined by given ranges `rows` and `columns`
     *
     * - Parameter rows: Range of indicies
     * - Parameter columns: Range of indicies
     *
     * - Returns: ``PDFTableSection`` with references to cells
     */
    subscript(rows rows: PartialRangeUpTo<Int>, columns columns: Range<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     * Accessors to the cells in the section defined by given ranges `rows` and `columns`
     *
     * - Parameter rows: Range of indicies
     * - Parameter columns: Range of indicies
     *
     * - Returns: ``PDFTableSection`` with references to cells
     */
    subscript(rows rows: PartialRangeUpTo<Int>, columns columns: ClosedRange<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     * Accessors to the cells in the section defined by given ranges `rows` and `columns`
     *
     * - Parameter rows: Range of indicies
     * - Parameter columns: Range of indicies
     *
     * - Returns: ``PDFTableSection`` with references to cells
     */
    subscript(rows rows: PartialRangeUpTo<Int>, columns columns: PartialRangeFrom<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     * Accessors to the cells in the section defined by given ranges `rows` and `columns`
     *
     * - Parameter rows: Range of indicies
     * - Parameter columns: Range of indicies
     *
     * - Returns: ``PDFTableSection`` with references to cells
     */
    subscript(rows rows: PartialRangeUpTo<Int>, columns columns: PartialRangeThrough<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     * Accessors to the cells in the section defined by given ranges `rows` and `columns`
     *
     * - Parameter rows: Range of indicies
     * - Parameter columns: Range of indicies
     *
     * - Returns: ``PDFTableSection`` with references to cells
     */
    subscript(rows rows: PartialRangeUpTo<Int>, columns columns: PartialRangeUpTo<Int>) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])]
        }
        set {
            self[rows: rows.relative(to: cells), columns: columns.relative(to: cells[0])] = newValue
        }
    }

    /**
     * Accessors to the cells in the section defined by given ranges `rows` and `columns`
     *
     * - Parameter rows: Range of indicies
     * - Parameter columns: Range of indicies
     *
     * - Returns: ``PDFTableSection`` with references to cells
     */
    subscript(rows rows: PartialRangeUpTo<Int>, column column: Int) -> PDFTableSection {
        get {
            self[rows: rows.relative(to: cells), columns: column...column]
        }
        set {
            self[rows: rows.relative(to: cells), columns: column...column] = newValue
        }
    }

    /**
     * Accessors to the cells in the section defined by given ranges `rows` and `columns`
     *
     * - Parameter rows: Range of indicies
     * - Parameter columns: Range of indicies
     *
     * - Returns: ``PDFTableSection`` with references to cells
     */
    subscript(rows rows: Range<Int>, columns columns: Range<Int>) -> PDFTableSection {
        get {
            PDFTableSection(cells: cells[rows].map { Array($0[columns]) }, of: self, in: rows, and: columns)
        }
        set {
            for (rowIdx, row) in rows.enumerated() {
                for (colIdx, column) in columns.enumerated() {
                    cells[row][column] = newValue.cells[rowIdx][colIdx]
                }
            }
        }
    }
}
