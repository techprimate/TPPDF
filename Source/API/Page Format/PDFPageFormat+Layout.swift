//
//  PDFPageFormat+Layout.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 08.11.2017.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
    import UIKit
#else
    import AppKit
#endif

public extension PDFPageFormat {
    /// Shorthand method to create a default `PDFPageLayout` based on the this formats `size`.
    var layout: PDFPageLayout {
        PDFPageLayout(
            size: size,
            margin: EdgeInsets(top: 60.0, left: 60.0, bottom: 60.0, right: 60.0),
            space: (header: 15.0, footer: 15.0)
        )
    }
}
