//
//  PDFTableContent+ContentType.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//

public extension PDFTableContent {
    /// Internal enumeration type used to identify the type-erased ``PDFTableContent/content``
    enum ContentType {
        /// Undefined content type
        case none

        /// Content is a string value
        case string

        /// Content is an attributed string
        case attributedString

        /// Content is an image
        case image
    }
}
