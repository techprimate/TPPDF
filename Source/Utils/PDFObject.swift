//
//  PDFObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//
//

public class PDFObject: TPJSONSerializable {

    var frame: CGRect = .zero
    var pagebreak = false
    
    func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFObject)] {
        return []
    }
    
    func updateHeights(generator: PDFGenerator, container: PDFContainer) {}
    func draw(generator: PDFGenerator, container: PDFContainer) throws {}
    
}
