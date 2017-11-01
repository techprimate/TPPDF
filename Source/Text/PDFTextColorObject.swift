//
//  PDFTextColorObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//
//

class PDFTextColorObject : PDFObject {
    
    var color: UIColor
    
    init(color: UIColor) {
        self.color = color
    }

    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFObject)] {
        generator.textColor[container] = color
        
        return [(container, self)]
    }
}
