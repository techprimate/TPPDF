//
//  PDFTableNode.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 21.12.2019.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
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
