//
//  PDFTableRow.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 20.12.19.
//

import Foundation

public class PDFTableRow {

    public let cells: [PDFTableCell]

    private let table: PDFTable
    private let position: Int

    internal init(cells: [PDFTableCell], of table: PDFTable, at position: Int) {
        self.cells = cells
        self.table = table
        self.position = position
    }
}
