//
//  PDFPageFormat+Margin.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//
//

public extension PDFPageFormat {
    
    public var layout: PDFPageLayout {
        return PDFPageLayout(size: self.size, margin: UIEdgeInsets(top: 60.0, left: 60.0, bottom: 60.0, right: 60.0), space: (header: 15.0, footer: 15.0))
    }
}
