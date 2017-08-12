//
//  PDFTableObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//
//

class PDFTableObject : PDFObject {
    
    var table: PDFTable
    
    init(table: PDFTable) {
        self.table = table
    }
}
