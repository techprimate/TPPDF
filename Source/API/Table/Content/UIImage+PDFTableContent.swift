//
//  UIImage+PDFTableContent.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 20.12.19.
//

#if os(iOS) || os(visionOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

// MARK: - Image + PDFTableContentable

extension Image: PDFTableContentable {
    /// Instance of ``PDFTableContent`` holding `self` as the content value
    public var asTableContent: PDFTableContent {
        PDFTableContent(type: .image, content: self)
    }
}
