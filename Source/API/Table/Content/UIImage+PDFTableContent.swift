//
//  Image+PDFTableContent.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 20.12.19.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/**
 Adds functionality to convert to PDF table content
 */
extension Image: PDFTableContentable {

    /**
     - returns: Instance of `PDFTableContent` of type image, using self as content
     */
    public var asTableContent: PDFTableContent {
        PDFTableContent(type: .image, content: self)
    }
}
