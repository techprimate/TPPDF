//
//  PDFTableNode.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 21.12.19.
//

import Foundation

class PDFTableNode {
    let cell: PDFTableCell
    let position: PDFTableCellPosition

    var moreRowsSpan: Int = 0
    var moreColumnsSpan: Int = 0

    init(cell: PDFTableCell, position: PDFTableCellPosition) {
        self.cell = cell
        self.position = position
    }
}
