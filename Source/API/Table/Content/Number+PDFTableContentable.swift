//
//  Number+PDFTableContentable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 16.05.20.
//

extension Int: PDFTableContentable {

    public var asTableContent: PDFTableContent {
        String(describing: self).asTableContent
    }
}

extension Double: PDFTableContentable {

    public var asTableContent: PDFTableContent {
        String(describing: self).asTableContent
    }
}

extension Float: PDFTableContentable {

    public var asTableContent: PDFTableContent {
        String(describing: self).asTableContent
    }
}
