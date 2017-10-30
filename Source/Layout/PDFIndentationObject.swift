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
    
    func calculate(generator: PDFGenerator, container: PDFContainer) throws {
        if left {
            generator.indentation.setLeft(indentation: indentation, in: container)
        } else {
            generator.indentation.setRight(indentation: indentation, in: container)
        }
    }
}
