//
//  PDFTableColumn.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 20.12.19.
//

import Foundation

public class PDFTableColumn {

    public let cells: [PDFTableCell]

    private let table: PDFTable
    private let position: Int

    internal init(cells: [PDFTableCell], of table: PDFTable, at position: Int) {
        self.cells = cells
        self.table = table
        self.position = position
    }

    /**
     Setter method to change the style of all cells in the column
     */
    public var style: PDFTableCellStyle {
        @available(*, unavailable)
        get {
            fatalError("You cannot read from this object.")
        }
        set {
            cells.forEach({ $0.style = newValue })
        }
    }

    /**
     Setter method to change the content of all cells in the column
     */
    public var content: PDFTableContent? {
        @available(*, unavailable)
        get {
            fatalError("You cannot read from this object.")
        }
        set {
            cells.forEach({ $0.content = newValue })
        }
    }

    /**
     Setter method to change the content of all cells in the column
     */
    public var alignment: PDFTableCellAlignment {
        @available(*, unavailable)
        get {
            fatalError("You cannot read from this object.")
        }
        set {
            cells.forEach({ $0.alignment = newValue })
        }
    }
}

extension PDFTableColumn: PDFTableMergable {

    /// nodoc
    public func merge() {
        self.merge(with: nil)
    }

    /**
     Merges all cells by replacing them with the same reference.

     If no parameter `cell` is given, the first cell in the column will be used.

     - parameter cell: Cell to use after merge, may be nil
     */
    public func merge(with cell: PDFTableCell? = nil) {
        for row in 0..<table.size.rows {
            table.cells[row][position] = cell ?? table.cells[row][0]
        }
    }
}
