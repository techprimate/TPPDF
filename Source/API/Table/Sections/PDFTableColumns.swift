//
//  PDFTableColumns.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 20.12.19.
//

import Foundation

/**
 References to multiple columns of a `PDFTable`
 */
public class PDFTableColumns {

    /**
     List of column references
     */
    public let columns: [PDFTableColumn]

    private let table: PDFTable
    private let range: Range<Int>

    internal init(columns: [PDFTableColumn], of table: PDFTable, in range: Range<Int>) {
        self.columns = columns
        self.table = table
        self.range = range
    }
}

extension PDFTableColumns: PDFTableMergable {

    /// nodoc
    public func merge() {
        self.merge(with: nil)
    }

    /**
     Merges all cells by replacing them with the same reference.

     If no parameter `cell` is given, the first cell in the first column will be used.

     - parameter cell: Cell to use after merge, may be nil
     */
    public func merge(with cell: PDFTableCell? = nil) {
        for column in columns {
            column.merge(with: cell)
        }
    }
}
