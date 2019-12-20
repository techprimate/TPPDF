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
