//
//  PDFTableContentable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 16.05.20.
//

/// Protocol to extend a type with a converter to ``PDFTableContent``
public protocol PDFTableContentable {
    /// Instance of ``PDFTableContent`` holding `self` as the content value
    var asTableContent: PDFTableContent { get }
}
