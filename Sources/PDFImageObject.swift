//
//  PDFImageObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//
//

class PDFImageObject : PDFObject {
    
    var image: PDFImage
    
    init(image: PDFImage) {
        self.image = image
    }
}
