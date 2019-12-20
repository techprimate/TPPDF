//
//  PDFTableColumns.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 20.12.19.
//

import Foundation

public class PDFTableColumns {

    public let columns: [PDFTableColumn]

    private let table: PDFTable
    private let range: Range<Int>

    internal init(columns: [PDFTableColumn], of table: PDFTable, in range: Range<Int>) {
        self.columns = columns
        self.table = table
        self.range = range
    }
}
