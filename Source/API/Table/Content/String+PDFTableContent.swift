//
//  String+PDFTableContent.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 20.12.19.
//

extension String: PDFTableContentable {
    /// Instance of ``PDFTableContent`` holding `self` as the content value
    public var asTableContent: PDFTableContent {
        PDFTableContent(type: .string, content: self)
    }
}
