//
//  PDFListObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//
//

class PDFListObject: PDFObject {
    
    var list: PDFList
    
    init(list: PDFList) {
        self.list = list
    }
}
