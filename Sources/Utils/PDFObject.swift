//
//  PDFObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//
//

public class PDFObject : TPJSONSerializable {

    var frame: CGRect = .zero
    
    func calculate(generator: PDFGenerator, container: PDFContainer) throws {}
    func updateHeights(generator: PDFGenerator, container: PDFContainer)  { }
    func draw(generator: PDFGenerator, container: PDFContainer) throws {}
    
}
