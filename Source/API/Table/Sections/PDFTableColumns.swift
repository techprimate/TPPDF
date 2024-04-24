//
//  PDFTableColumns.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 20.12.19.
//

import Foundation

/// References to multiple columns (``PDFTableColumn``) of a ``PDFTable``
public class PDFTableColumns {
    /// Array of references to ``PDFTableColumn``
    public let columns: [PDFTableColumn]

    /// Reference to the ``PDFTable``
    private let table: PDFTable

    /// Range of columns in the ``PDFTableColumns/table``
    private let range: Range<Int>

    /// Creates a new
    init(columns: [PDFTableColumn], of table: PDFTable, in range: Range<Int>) {
        self.columns = columns
        self.table = table
        self.range = range
    }

    /**
     * Access content of all cells in all columns or sets the content of a subsection of cells.
     *
     * If the bounds of the section is exceeded, when setting new values, an assertion error will be thrown.
     */
    public var content: [[PDFTableContentable?]] {
        get {
            columns.map(\.content)
        }
        set {
            assert(newValue.count <= columns.count, "Can not access more rows than available")
            for (columnIdx, column) in columns.enumerated() {
                column.content = newValue[columnIdx]
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
            columns.forEach { $0.content = newValue }
        }
    }

    /**
     * Setter method to change the content of all cells in the column
     *
     * - Note: This method can not be used to get contents, because the type can only be a single value.
     */
    public var allCellsContent: PDFTableContent? {
        @available(*, unavailable)
        get {
            fatalError("You cannot read from this object.")
        }
        set {
            columns.forEach { $0.allCellsContent = newValue }
        }
    }

    /**
     * Access style of all cells in section or sets a content of a subsection of cells.
     *
     * If the bounds of the section is exceeded, when setting new values, an assertion error will be thrown.
     */
    public var style: [[PDFTableCellStyle?]] {
        get {
            columns.map(\.style)
        }
        set {
            assert(newValue.count <= columns.count, "Can not access more rows than available")
            for (columnIdx, column) in columns.enumerated() {
                column.style = newValue[columnIdx]
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
            columns.forEach { $0.style = newValue }
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
            columns.forEach { $0.allCellsStyle = newValue }
        }
    }

    /**
     * Access alignment of all cells in section or sets a content of a subsection of cells.
     *
     * If the bounds of the section is exceeded, when setting values, an assertion error will be thrown.
     */
    public var alignment: [[PDFTableCellAlignment]] {
        get {
            columns.map(\.alignment)
        }
        set {
            assert(newValue.count <= columns.count, "Can not access more rows than available")
            for (columnIdx, column) in columns.enumerated() {
                column.alignment = newValue[columnIdx]
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
            assert(newValue.count <= columns.count, "Can not access more columns than available")
            columns.forEach { $0.alignment = newValue }
        }
    }

    /**
     * Setter method to change the style of all cells in the columns
     *
     * - Note: This method can not be used to get alignments, because the type can only be a single value.
     */
    public var allCellsAlignment: PDFTableCellAlignment {
        @available(*, unavailable)
        get {
            fatalError("You cannot read from this object.")
        }
        set {
            columns.forEach { $0.allCellsAlignment = newValue }
        }
    }
}

// MARK: PDFTableMergable

extension PDFTableColumns: PDFTableMergable {
    /// nodoc
    public func merge() {
        merge(with: nil)
    }

    /**
     * Merges all cells by replacing them with the same reference.
     *
     * If no parameter `cell` is given, the first cell in the first column will be used.
     *
     * - Parameter cell: Cell to use after merge, may be nil
     */
    public func merge(with cell: PDFTableCell? = nil) {
        for column in columns {
            column.merge(with: cell)
        }
    }
}
