//
//  PDFFontObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

class PDFFontObject: PDFObject {
    
    var font: UIFont
    
    init(font: UIFont) {
        self.font = font
    }

    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFObject)] {
        generator.fonts[container] = font

        return [(container, self)]
    }
}
