//
//  PDFPageFormat+Margin.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//
//

public extension PDFPageFormat {
    
    public var layout: PDFLayout {
        return PDFLayout(size: self.size, margin: (header: 30.0, footer: 30.0, side: 60.0), space: (header: 15.0, footer: 15.0))
    }
}
