//
//  NSAttributedString+PDFTableContent.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 20.12.19.
//

import Foundation

/**
 TODO: Documentation
 */
public extension NSAttributedString {

    /**
     TODO: Documentation
     */
    func toPDFTableContent() -> PDFTableContent {
        PDFTableContent(type: .attributedString, content: self)
    }
}
