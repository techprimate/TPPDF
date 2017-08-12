//
//  PDFImageRowObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//
//

class PDFImageRowObject : PDFObject {
    
    var images: [PDFImage]
    var spacing: CGFloat
    
    init(images: [PDFImage], spacing: CGFloat = 1.0) {
        self.images = images
        self.spacing = spacing
    }
}
