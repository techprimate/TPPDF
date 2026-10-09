//
//  String+PDFTableContent.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 20.12.2019.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

extension String: PDFTableContentable {
    /// Instance of ``PDFTableContent`` holding `self` as the content value
    public var asTableContent: PDFTableContent {
        PDFTableContent(type: .string, content: self)
    }
}
