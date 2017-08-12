//
//  PDFFontObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//
//

class PDFFontObject : PDFObject {
    
    var font: UIFont
    
    init(font: UIFont) {
        self.font = font
    }
}
