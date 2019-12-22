//
//  PDFTableNode.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 21.12.19.
//

import Foundation

internal class PDFTableNode {

    internal let cell: PDFTableCell
    internal let position: PDFTableCellPosition

    internal var moreRowsSpan: Int = 0
    internal var moreColumnsSpan: Int = 0

    internal init(cell: PDFTableCell, position: PDFTableCellPosition) {
        self.cell = cell
        self.position = position
    }
}
