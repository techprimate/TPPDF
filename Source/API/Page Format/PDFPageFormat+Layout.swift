//
//  PDFPageFormat+Layout.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//

#if os(iOS) || os(visionOS)
    import UIKit
#elseif os(macOS)
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
