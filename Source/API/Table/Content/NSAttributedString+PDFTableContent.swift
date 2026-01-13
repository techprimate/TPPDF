//
//  NSAttributedString+PDFTableContent.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 20.12.2019.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

import Foundation

/// Adds functionality to convert to PDF table content
extension NSAttributedString: PDFTableContentable {
    /// Instance of ``PDFTableContent`` of type attributed string, using `self` as content
    public var asTableContent: PDFTableContent {
        PDFTableContent(type: .attributedString, content: self)
    }
}
