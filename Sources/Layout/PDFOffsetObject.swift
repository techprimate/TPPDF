//
//  PDFOffsetObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//
//

class PDFOffsetObject : PDFObject {
    
    var offset: CGFloat
    
    init(offset: CGFloat) {
        self.offset = offset
    }
    
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws {
        generator.setContentOffset(container, value: offset)
    }
}
