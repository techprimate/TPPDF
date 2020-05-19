//
//  NSAttributedString+PDFTableContent.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 20.12.19.
//

import Foundation

/**
 Adds functionality to convert to PDF table content
 */
extension NSAttributedString: PDFTableContentable {

    /**
    - returns: Instance of `PDFTableContent` of type attributed string, using self as content
     */
    public var asTableContent: PDFTableContent {
        PDFTableContent(type: .attributedString, content: self)
    }
}
