//
//  PDFPageBreakObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//
//

class PDFPageBreakObject: PDFObject {
    
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFObject)] {
        generator.layout.heights.content = 0
        generator.currentPage += 1
        generator.totalPages += 1

        return [(container, self)]
    }

    override func draw(generator: PDFGenerator, container: PDFContainer) throws {
        UIGraphicsBeginPDFPage()
        generator.drawDebugPageOverlay()
    }
    
}
