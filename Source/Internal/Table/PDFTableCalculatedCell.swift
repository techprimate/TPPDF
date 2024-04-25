//
//  PDFTableCalculatedCell.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 19.07.20.
//

import CoreGraphics

struct PDFTableCalculatedCell {
    var cell: PDFTableCell
    var type: PDFTableObject.CellType
    var style: PDFTableCellStyle
    var frames: (cell: CGRect, content: CGRect)
}
