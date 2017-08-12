//
//  PDFLineSeparator.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//
//

class PDFLineSeparatorObject : PDFObject {
    
    var style: PDFLineStyle
    
    init(style: PDFLineStyle = PDFLineStyle()) {
        self.style = style
    }
}
