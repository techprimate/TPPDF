//
//  PDFTableContentable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 16.05.2020.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

/// Protocol to extend a type with a converter to ``PDFTableContent``
public protocol PDFTableContentable {
    /// Instance of ``PDFTableContent`` holding `self` as the content value
    var asTableContent: PDFTableContent { get }
}
