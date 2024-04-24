//
//  PDFTableRows.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 20.12.19.
//

import Foundation

/// References to multiple rows (``PDFTableRow``) of a ``PDFTable``
public class PDFTableRows {
    /// Array of references to ``PDFTableRow``
    public let rows: [PDFTableRow]

    /// Reference to the ``PDFTable``
    private let table: PDFTable

    /// Range of rows in the ``PDFTableRows/table``
    private let range: Range<Int>

    /**
     * Creates a new reference to multiple rows in a table.
     *
     * - Parameters:
     *     - rows: See ``PDFTableRows/rows`` for details
     *     - table: See ``PDFTableRows/table`` for details
     *     - range: See ``PDFTableRows/range`` for details
     */
    init(rows: [PDFTableRow], of table: PDFTable, in range: Range<Int>) {
        self.rows = rows
        self.table = table
        self.range = range
    }

    /**
     * Access content of all cells in all rows or sets the content of a subsection of cells.
     *
     * If the bounds of the section is exceeded, when setting new values, an assertion error will be thrown.
     */
    public var content: [[PDFTableContentable?]] {
        get {
            rows.map(\.content)
        }
        set {
            assert(newValue.count <= rows.count, "Can not access more rows than available")
            for (rowIdx, row) in rows.enumerated() {
                row.content = newValue[rowIdx]
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
            rows.forEach { $0.content = newValue }
        }
    }

    /**
     * Setter method to change the content of all cells in the row
     *
     * - Note: This method can not be used to get contents, because the type can only be a single value.
     */
    public var allCellsContent: PDFTableContent? {
        @available(*, unavailable)
        get {
            fatalError("You cannot read from this object.")
        }
        set {
            rows.forEach { $0.allCellsContent = newValue }
        }
    }

    /**
     * Access style of all cells in section or sets a content of a subsection of cells.
     *
     * If the bounds of the section is exceeded, when setting new values, an assertion error will be thrown.
     */
    public var style: [[PDFTableCellStyle?]] {
        get {
            rows.map(\.style)
        }
        set {
            assert(newValue.count <= rows.count, "Can not access more rows than available")
            for (rowIdx, row) in rows.enumerated() {
                row.style = newValue[rowIdx]
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
            rows.forEach { $0.style = newValue }
        }
    }

    /**
     * Setter method to change the style of all cells in the row
     *
     * - Note: This method can not be used to get styles, because the type can only be a single value.
     */
    public var allCellsStyle: PDFTableCellStyle? {
        @available(*, unavailable)
        get {
            fatalError("You cannot read from this object.")
        }
        set {
            rows.forEach { $0.allCellsStyle = newValue }
        }
    }

    /**
     * Access alignment of all cells in section or sets a content of a subsection of cells.
     *
     * If the bounds of the section is exceeded, when setting values, an assertion error will be thrown.
     */
    public var alignment: [[PDFTableCellAlignment]] {
        get {
            rows.map(\.alignment)
        }
        set {
            assert(newValue.count <= rows.count, "Can not access more rows than available")
            for (rowIdx, row) in rows.enumerated() {
                row.alignment = newValue[rowIdx]
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
            for row in rows {
                assert(newValue.count <= row.cells.count, "Can not access more rows than available")
                row.alignment = newValue
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
            rows.forEach { $0.allCellsAlignment = newValue }
        }
    }
}

// MARK: PDFTableMergable

extension PDFTableRows: PDFTableMergable {
    /// nodoc
    public func merge() {
        merge(with: nil)
    }

    /**
     * Merges all cells by replacing them with the same reference.
     *
     * If no parameter `cell` is given, the first cell in the first row will be used.
     *
     * - Parameter cell: Cell to use after merge, may be nil
     */
    public func merge(with cell: PDFTableCell? = nil) {
        for row in rows {
            row.merge(with: cell)
        }
    }
}
