//
//  PDFTableRows.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 20.12.19.
//

import Foundation

public class PDFTableRows {

    public let rows: [PDFTableRow]

    private let table: PDFTable
    private let range: Range<Int>

    internal init(rows: [PDFTableRow], of table: PDFTable, in range: Range<Int>) {
        self.rows = rows
        self.table = table
        self.range = range
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

