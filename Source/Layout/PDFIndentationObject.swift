//
//  PDFIndentationObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//
//

class PDFIndentationObject: PDFObject {
    
    var indentation: CGFloat
    var left: Bool
    
    init(indentation: CGFloat, left: Bool) {
        self.indentation = indentation
        self.left = left
    }
    
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFObject)] {
        if left {
            generator.layout.indentation.setLeft(indentation: indentation, in: container)
        } else {
            generator.layout.indentation.setRight(indentation: indentation, in: container)
        }
        
        return [(container, self)]
    }
}
