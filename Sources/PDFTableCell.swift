//
//  PDFTableCell.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//
//

open class PDFTableCell {
    
    open var content: PDFTableContent?
    open var alignment: PDFTableCellAlignment
    open var style: PDFTableCellStyle?
    
    init(content: PDFTableContent? = nil, alignment: PDFTableCellAlignment = .center, style: PDFTableCellStyle? = nil) {
        self.content = content
        self.alignment = alignment
        self.style = style
    }
}
