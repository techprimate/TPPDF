//
//  PDFIndentationObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//
//

class PDFIndentationObject: PDFObject {
    
    var indentation: CGFloat
    
    init(indentation: CGFloat) {
        self.indentation = indentation
    }
    
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws {
        generator.indentation[container.normalize] = indentation
    }
}
