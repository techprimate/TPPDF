//
//  UIImage+PDFTableContent.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 20.12.19.
//

import UIKit

/**
 Adds functionality to convert to PDF table content
 */
extension UIImage: PDFTableContentable {

    /**
     - returns: Instance of `PDFTableContent` of type image, using self as content
     */
    public var asTableContent: PDFTableContent {
        PDFTableContent(type: .image, content: self)
    }
}
