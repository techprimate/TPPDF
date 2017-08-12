//
//  PDFAttributedTextObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//
//

class PDFAttributedTextObject : PDFObject {
    
    var text: NSAttributedString
    
    init(text: NSAttributedString) {
        self.text = text
    }
}
