//
//  UIImage+PDFTableContent.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 20.12.19.
//

import Foundation

/**
 TODO: Documentation
 */
public extension UIImage {

    /**
     TODO: Documentation
     */
    func toPDFTableContent() -> PDFTableContent {
        PDFTableContent(type: .image, content: self)
    }
}
