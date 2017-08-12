//
//  PDFTextObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//
//

class PDFTextObject : PDFObject {
    
    var text: String
    var lineSpacing: CGFloat
    
    init(text: String, lineSpacing: CGFloat = 1.0) {
        self.text = text
        self.lineSpacing = lineSpacing
    }
}
