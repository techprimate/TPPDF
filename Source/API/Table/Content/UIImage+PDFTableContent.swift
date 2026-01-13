//
//  UIImage+PDFTableContent.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 20.12.2019.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
    import UIKit
#else
    import AppKit
#endif

// MARK: - Image + PDFTableContentable

extension Image: PDFTableContentable {
    /// Instance of ``PDFTableContent`` holding `self` as the content value
    public var asTableContent: PDFTableContent {
        PDFTableContent(type: .image, content: self)
    }
}
