//
//  PDFTableCalculatedCell.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 19.07.2020.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

import CoreGraphics

struct PDFTableCalculatedCell {
    var cell: PDFTableCell
    var type: PDFTableObject.CellType
    var style: PDFTableCellStyle
    var frames: (cell: CGRect, content: CGRect)
}
