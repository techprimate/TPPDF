//
//  PDFTableCell.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//

public class PDFTableCell: PDFJSONSerializable {
    
    public var content: PDFTableContent?
    public var alignment: PDFTableCellAlignment
    public var style: PDFTableCellStyle?
    
    init(content: PDFTableContent? = nil, alignment: PDFTableCellAlignment = .center, style: PDFTableCellStyle? = nil) {
        self.content = content
        self.alignment = alignment
        self.style = style
    }
}
