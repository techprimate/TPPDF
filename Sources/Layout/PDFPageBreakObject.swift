//
//  PDFPageBreakObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//
//

class PDFPageBreakObject : PDFObject {
    
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws {
        try generator.generateNewPage(calculatingMetrics: true)
    }

    override func draw(generator: PDFGenerator, container: PDFContainer) throws {
        try generator.generateNewPage(calculatingMetrics: false)
    }
    
}
