//
//  PDFTableSection.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 20.12.19.
//

import Foundation

/// Reference to a range of cells in a ``PDFTable``
public class PDFTableSection {
    /// References to cells in the ``PDFTable``
    public let cells: [[PDFTableCell]]

    private let table: PDFTable
    private let rowsRange: Range<Int>
    private let columnsRange: Range<Int>

    init(cells: [[PDFTableCell]], of table: PDFTable, in rowsRange: Range<Int>, and columnsRange: Range<Int>) {
        self.cells = cells
        self.table = table
        self.rowsRange = rowsRange
        self.columnsRange = columnsRange
    }

    /**
     * Access content of all cells in section or sets a content of a subsection of cells.
     *
     * If the bounds of the section is exceeded, when setting new values, an assertion error will be thrown.
     */
    public var content: [[PDFTableContent?]] {
        get {
            cells.map { row in
                row.map(\.content)
            }
        }
        set {
            assert(newValue.count <= cells.count, "Can not access more rows than available")
            for (rowIdx, row) in cells.enumerated() {
                assert(rowIdx < row.count, "Can not access more columns than given in row \(rowIdx)")
                for (colIdx, col) in row.enumerated() {
                    col.content = newValue[rowIdx][colIdx]
                }
            }
        }
    }

    /**
     * Setter method to change the content of all rows to the same
     *
     * - Note: This method can not be used to get contents, because the type can only be a single value per row.
     */
    public var allRowsContent: [PDFTableContent?] {
        @available(*, unavailable)
        get {
            fatalError("You cannot read from this object.")
        }
        set {
            assert(newValue.count <= columnsRange.count, "Can not access more columns than available")
            for rowIdx in rowsRange {
                for colIdx in 0..<newValue.count {
                    cells[rowIdx][colIdx].content = newValue[colIdx]
                }
            }
        }
    }

    /**
     * Setter method to change the content of all cells in the column
     *
     * - Note: This method can not be used to get contents, because the type can only be a single value per column.
     */
    public var allColumnsContent: [PDFTableContent?] {
        @available(*, unavailable)
        get {
            fatalError("You cannot read from this object.")
        }
        set {
            assert(newValue.count <= columnsRange.count, "Can not access more columns than available")
            for rowIdx in 0..<newValue.count {
                for colIdx in 0..<cells[rowIdx].count {
                    cells[rowIdx][colIdx].content = newValue[rowIdx]
                }
            }
        }
    }

    /**
     * Setter method to change the content of all cells in the section
     *
     * - Note: This method can not be used to get contents, because the type can only be a single value.
     */
    public var allCellsContent: PDFTableContent? {
        @available(*, unavailable)
        get {
            fatalError("You cannot read from this object.")
        }
        set {
            for row in cells {
                for cell in row {
                    cell.content = newValue
                }
            }
        }
    }

    /**
     * Access style of all cells in section or sets a content of a subsection of cells.
     *
     * If the bounds of the section is exceeded, when setting new values, an assertion error will be thrown.
     */
    public var style: [[PDFTableCellStyle?]] {
        get {
            cells.map { row in
                row.map(\.style)
            }
        }
        set {
            assert(newValue.count <= cells.count, "Can not access more rows than available")
            for (rowIdx, row) in cells.enumerated() {
                assert(rowIdx < row.count, "Can not access more columns than given in row \(rowIdx)")
                for (colIdx, col) in row.enumerated() {
                    col.style = newValue[rowIdx][colIdx]
                }
            }
        }
    }

    /**
     * Setter method to change the style of all cells in the row
     *
     * - Note: This method can not be used to get styles, because the type can only be a single value per row
     */
    public var allRowsStyle: [PDFTableCellStyle?] {
        @available(*, unavailable)
        get {
            fatalError("You cannot read from this object.")
        }
        set {
            assert(newValue.count <= columnsRange.count, "Can not access more columns than available")
            for row in cells {
                for colIdx in 0..<newValue.count {
                    row[colIdx].style = newValue[colIdx]
                }
            }
        }
    }

    /**
     * Setter method to change the style of all cells in the column
     *
     * - Note: This method can not be used to get styles, because the type can only be a single value per column
     */
    public var allColumnsStyle: [PDFTableCellStyle?] {
        @available(*, unavailable)
        get {
            fatalError("You cannot read from this object.")
        }
        set {
            assert(newValue.count <= columnsRange.count, "Can not access more columns than available")
            for rowIdx in 0..<newValue.count {
                for colIdx in 0..<cells[rowIdx].count {
                    cells[rowIdx][colIdx].style = newValue[rowIdx]
                }
            }
        }
    }

    /**
     * Setter method to change the style of all cells in the column
     *
     * - Note: This method can not be used to get styles, because the type can only be a single value.
     */
    public var allCellsStyle: PDFTableCellStyle? {
        @available(*, unavailable)
        get {
            fatalError("You cannot read from this object.")
        }
        set {
            for row in cells {
                for cell in row {
                    cell.style = newValue
                }
            }
        }
    }

    /**
     * Access alignment of all cells in section or sets a content of a subsection of cells.
     *
     * If the bounds of the section is exceeded, when setting values, an assertion error will be thrown.
     */
    public var alignment: [[PDFTableCellAlignment]] {
        get {
            cells.map { row in
                row.map(\.alignment)
            }
        }
        set {
            assert(newValue.count <= cells.count, "Can not access more rows than available")
            for (rowIdx, row) in cells.enumerated() {
                assert(rowIdx < row.count, "Can not access more columns than given in row \(rowIdx)")
                for (colIdx, col) in row.enumerated() {
                    col.alignment = newValue[rowIdx][colIdx]
                }
            }
        }
    }

    /**
     * Setter method to change the style of all cells in the rows
     *
     * - Note: This method can not be used to get alignment, because the type can only be a single value per row
     */
    public var allRowsAlignment: [PDFTableCellAlignment] {
        @available(*, unavailable)
        get {
            fatalError("You cannot read from this object.")
        }
        set {
            assert(newValue.count <= columnsRange.count, "Can not access more columns than available")
            for row in cells {
                for colIdx in 0..<newValue.count {
                    row[colIdx].alignment = newValue[colIdx]
                }
            }
        }
    }

    /**
     * Setter method to change the style of all cells in the columns
     *
     * - Note: This method can not be used to get alignment, because the type can only be a single value per column
     */
    public var allColumnsAlignment: [PDFTableCellAlignment] {
        @available(*, unavailable)
        get {
            fatalError("You cannot read from this object.")
        }
        set {
            assert(newValue.count <= columnsRange.count, "Can not access more columns than available")
            for rowIdx in 0..<newValue.count {
                for colIdx in 0..<cells[rowIdx].count {
                    cells[rowIdx][colIdx].alignment = newValue[rowIdx]
                }
            }
        }
    }

    /**
     * Setter method to change the style of all cells in the rows
     *
     * - Note: This method can not be used to get alignments, because the type can only be a single value.
     */
    public var allCellsAlignment: PDFTableCellAlignment {
        @available(*, unavailable)
        get {
            fatalError("You cannot read from this object.")
        }
        set {
            for row in cells {
                for cell in row {
                    cell.alignment = newValue
                }
            }
        }
    }
}

public extension PDFTableSection {
    /// nodoc
    func merge() {
        merge(with: nil)
    }

    /**
     * Merges all cells by replacing them with the same reference.
     *
     * If no parameter `cell` is given, the first cell in the first row and the first column will be used.
     *
     * - Parameter cell: Cell to use after merge, may be nil
     */
    func merge(with cell: PDFTableCell? = nil) {
        for row in rowsRange {
            for column in columnsRange {
                table.cells[row][column] = cell ?? table.cells[rowsRange.first!][columnsRange.first!]
            }
        }
    }
}
