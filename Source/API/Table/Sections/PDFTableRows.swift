//
//  PDFTableRows.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 20.12.19.
//

import Foundation

/**
 References to multiple rows of a `PDFTable`
 */
public class PDFTableRows {

    /**
     List of row references
     */
    public let rows: [PDFTableRow]

    private let table: PDFTable
    private let range: Range<Int>

    internal init(rows: [PDFTableRow], of table: PDFTable, in range: Range<Int>) {
        self.rows = rows
        self.table = table
        self.range = range
    }

    /**
     Access content of all cells in all rows or sets the content of a subsection of cells.

     If the bounds of the section is exceeded, when setting new values, an assertion error will be thrown.
     */
    public var content: [[PDFTableContentable?]] {
        get {
            rows.map(\.content)
        }
        set {
            assert(newValue.count <= rows.count, "Can not access more rows than available")
            rows.enumerated().forEach { (rowIdx, row) in
                row.content = newValue[rowIdx]
            }
        }
    }

    /**
     Setter method to change the content of all rows to the same
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
     Setter method to change the content of all cells in the row
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
     Access style of all cells in section or sets a content of a subsection of cells.

     If the bounds of the section is exceeded, when setting new values, an assertion error will be thrown.
     */
    public var style: [[PDFTableCellStyle?]] {
        get {
            rows.map(\.style)
        }
        set {
            assert(newValue.count <= rows.count, "Can not access more rows than available")
            rows.enumerated().forEach { (rowIdx, row) in
                row.style = newValue[rowIdx]
            }
        }
    }

    /**
     Setter method to change the style of all rows to the same
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
     Setter method to change the style of all cells in the row
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
     Access alignment of all cells in section or sets a content of a subsection of cells.

     If the bounds of the section is exceeded, when setting values, an assertion error will be thrown.
     */
    public var alignment: [[PDFTableCellAlignment]] {
        get {
            rows.map(\.alignment)
        }
        set {
            assert(newValue.count <= rows.count, "Can not access more rows than available")
            rows.enumerated().forEach { (rowIdx, row) in
                row.alignment = newValue[rowIdx]
            }
        }
    }

    /**
     Sets the same alignment for each row

     If the bounds of the section is exceeded, an assertion error will be thrown.
     */
    public var allRowsAlignment: [PDFTableCellAlignment] {
        @available(*, unavailable)
        get {
            fatalError("You cannot read from this object.")
        }
        set {
            rows.forEach {
                assert(newValue.count <= $0.cells.count, "Can not access more columns than available")
                $0.alignment = newValue
            }
        }
    }

    /**
     Setter method to change the style of all cells in the rows
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

extension PDFTableRows: PDFTableMergable {

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
        for row in rows {
            row.merge(with: cell)
        }
    }
}
