//
//  Number+PDFTableContentable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 16.05.2020.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

// MARK: - Int + PDFTableContentable

extension Int: PDFTableContentable {
    /// Converts this ``Int`` to a ``PDFTableContent``
    public var asTableContent: PDFTableContent {
        String(describing: self).asTableContent
    }
}

// MARK: - Double + PDFTableContentable

extension Double: PDFTableContentable {
    /// Converts this ``Double`` to a ``PDFTableContent``
    public var asTableContent: PDFTableContent {
        String(describing: self).asTableContent
    }
}

// MARK: - Float + PDFTableContentable

extension Float: PDFTableContentable {
    /// Converts this ``Float`` to a ``PDFTableContent``
    public var asTableContent: PDFTableContent {
        String(describing: self).asTableContent
    }
}
