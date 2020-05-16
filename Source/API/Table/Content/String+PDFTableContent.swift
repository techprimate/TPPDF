//
//  String+PDFTableContent.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 20.12.19.
//

/**
 Adds functionality to convert to PDF table content
 */
extension String: PDFTableContentable {

    /**
     - returns: Instance of `PDFTableContent` of type string, using self as content
     */
    public var asTableContent: PDFTableContent {
        PDFTableContent(type: .string, content: self)
    }
}
