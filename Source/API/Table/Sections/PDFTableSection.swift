//
//  PDFTableSection.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 20.12.19.
//

import Foundation

public class PDFTableSection {

    public let cells: [[PDFTableCell]]

    private let table: PDFTable
    private let rowsRange: Range<Int>
    private let columnsRange: Range<Int>

    internal init(cells: [[PDFTableCell]], of table: PDFTable, in rowsRange: Range<Int>, and columnsRange: Range<Int>) {
        self.cells = cells
        self.table = table
        self.rowsRange = rowsRange
        self.columnsRange = columnsRange
    }
}
