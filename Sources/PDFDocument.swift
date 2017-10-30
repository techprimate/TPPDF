//
//  PDFDocument.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//
//

public class PDFDocument: TPJSONSerializable {
    
    public var layout: PDFLayout
    public var info: PDFInfo = PDFInfo()
    public var pagination: PDFPagination = PDFPagination()
    
    var objects: [(PDFContainer, PDFObject)] = []
    
    public init(layout: PDFLayout) {
        self.layout = layout
    }
    
    public init(format: PDFPageFormat) {
        self.layout = format.layout
    }
}
