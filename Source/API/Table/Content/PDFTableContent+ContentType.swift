//
//  PDFTableContent+ContentType.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 06.13.2017.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
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
