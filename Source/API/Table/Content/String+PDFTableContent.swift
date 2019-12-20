//
//  String+PDFTableContent.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 20.12.19.
//

import Foundation

/**
 TODO: Documentation
 */
public extension String {

    /**
     TODO: Documentation
     */
    func toPDFTableContent() -> PDFTableContent {
        return PDFTableContent(type: .string, content: self)
    }
}
