//
//  PDFObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

class PDFObject: TPJSONSerializable {

    var frame: CGRect = .zero
    
    func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFObject)] {
        return []
    }
    
    func draw(generator: PDFGenerator, container: PDFContainer) throws {}
    
}
