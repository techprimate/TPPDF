//
//  PDFTableColumn.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 20.12.19.
//

import Foundation

/// Reference to a single column of cells in a ``PDFTable``
public class PDFTableColumn {
    /// References to the cells in the column
    public private(set) var cells: [PDFTableCell]

    /// Reference to the ``PDFTable``
    private let table: PDFTable

    /// Range of rows in the ``PDFTableColumn/table``
    private let position: Int

    /**
     * Creates a new reference to a row of cells in a table.
     *
     * - Parameters:
     *     - cells: See ``PDFTableRows/cells`` for details
     *     - table: See ``PDFTableRows/table`` for details
     *     - position: See ``PDFTableRows/position`` for details
     */
    init(cells: [PDFTableCell], of table: PDFTable, at position: Int) {
        self.cells = cells
        self.table = table
        self.position = position
    }

    /// Access and modifier for a specific cell in a given row
    public subscript(row: Int) -> PDFTableCell {
        get {
            cells[row]
        }
        set {
            cells[row] = newValue
            table.cells[row][position] = newValue
        }
    }

    /**
     * Access content of all cells in column or sets a content of a subsection of cells.
     *
     * If the bounds of the section is exceeded, when setting new values, an assertion error will be thrown.
     */
    public var content: [PDFTableContentable?] {
        get {
            cells.map(\.content)
        }
        set {
            assert(newValue.count <= cells.count, "Can not access more cells than available")
            for (idx, cell) in cells.enumerated() {
                cell.content = newValue[idx]?.asTableContent
            }
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
            cells.forEach { $0.content = newValue }
        }
    }

    /**
     * Access content of all cells in column or sets a content of a subsection of cells.
     *
     * If the bounds of the section is exceeded, when setting new values, an assertion error will be thrown.
     */
    public var style: [PDFTableCellStyle?] {
        get {
            cells.map(\.style)
        }
        set {
            assert(newValue.count <= cells.count, "Can not access more cells than available")
            for (idx, cell) in cells.enumerated() {
                cell.style = newValue[idx]
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
            cells.forEach { $0.style = newValue }
        }
    }

    /**
     * Access content of all cells in column or sets a content of a subsection of cells.
     *
     * If the bounds of the section is exceeded, when setting new values, an assertion error will be thrown.
     */
    public var alignment: [PDFTableCellAlignment] {
        get {
            cells.map(\.alignment)
        }
        set {
            assert(newValue.count <= cells.count, "Can not access more cells than available")
            for (idx, cell) in cells.enumerated() {
                cell.alignment = newValue[idx]
            }
        }
    }

    /**
     * Setter method to change the content of all cells in the column
     *
     * - Note: This method can not be used to get values, because the type can only be a single value.
     */
    public var allCellsAlignment: PDFTableCellAlignment {
        @available(*, unavailable)
        get {
            fatalError("You cannot read from this object.")
        }
        set {
            cells.forEach { $0.alignment = newValue }
        }
    }
}

// MARK: PDFTableMergable

extension PDFTableColumn: PDFTableMergable {
    /// nodoc
    public func merge() {
        merge(with: nil)
    }

    /**
     * Merges all cells by replacing them with the same reference.
     *
     * If no parameter `cell` is given, the first cell in the column will be used.
     *
     * - Parameter cell: Cell to use after merge, may be nil
     */
    public func merge(with cell: PDFTableCell? = nil) {
        for row in 0..<table.size.rows {
            table.cells[row][position] = cell ?? table.cells[0][position]
        }
    }
}
