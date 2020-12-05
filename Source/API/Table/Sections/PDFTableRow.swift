//
//  PDFTableRow.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 20.12.19.
//

import Foundation

/**
 Reference to a single row of cells in a `PDFTable`
 */
public class PDFTableRow {

    /**
     References to the cells in the row
     */
    public let cells: [PDFTableCell]

    private let table: PDFTable
    private let position: Int

    internal init(cells: [PDFTableCell], of table: PDFTable, at position: Int) {
        self.cells = cells
        self.table = table
        self.position = position
    }

    /**
     Access content of all cells in row or sets a content of a subsection of cells.

     If the bounds of the section is exceeded, when setting new values, an assertion error will be thrown.
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
     Setter method to change the content of all cells in the row
     */
    public var allCellsContent: PDFTableContent? {
        @available(*, unavailable)
        get {
            fatalError("You cannot read from this object.")
        }
        set {
            cells.forEach({ $0.content = newValue })
        }
    }

    /**
     Access content of all cells in row or sets a content of a subsection of cells.

     If the bounds of the section is exceeded, when setting new values, an assertion error will be thrown.
     */
    public var style: [PDFTableCellStyle?] {
        get {
            cells.map(\.style)
        }
        set {
            assert(newValue.count <= cells.count, "Can not access more cells than available")
            for (idx, cell) in cells.enumerated() where idx <= newValue.count - 1 {
                cell.style = newValue[idx]
            }
        }
    }

    /**
     Setter method to change the style of all cells in the row
     */
    public var allCellsStyle: PDFTableCellStyle? {
        @available(*, unavailable)
        get {
            fatalError("You cannot read from this object.")
        }
        set {
            cells.forEach({ $0.style = newValue })
        }
    }

    /**
     Access content of all cells in row or sets a content of a subsection of cells.

     If the bounds of the section is exceeded, when setting new values, an assertion error will be thrown.
     */
    public var alignment: [PDFTableCellAlignment] {
        get {
            cells.map(\.alignment)
        }
        set {
            assert(newValue.count <= cells.count, "Can not access more cells than available")
            for (idx, cell) in cells.enumerated() where idx <= newValue.count - 1 {
                cell.alignment = newValue[idx]
            }
        }
    }

    /**
     Setter method to change the content of all cells in the row
     */
    public var allCellsAlignment: PDFTableCellAlignment {
        @available(*, unavailable)
        get {
            fatalError("You cannot read from this object.")
        }
        set {
            cells.forEach({ $0.alignment = newValue })
        }
    }
}

extension PDFTableRow: PDFTableMergable {

    /// nodoc
    public func merge() {
        self.merge(with: nil)
    }

    /**
     Merges all cells by replacing them with the same reference.

     If no parameter `cell` is given, the first cell in the first row will be used.

     - parameter cell: Cell to use after merge, may be nil
     */
    public func merge(with cell: PDFTableCell? = nil) {
        table.cells[position] = Array(repeating: cell ?? table.cells[position][0], count: table.size.columns)
    }
}
