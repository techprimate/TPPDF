//
//  PDFPageFormat+Margin.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/**
 Extends the PDF page format with pdf layout methods
 */
public extension PDFPageFormat {

    /**
     Shorthand method to create a default `PDFPageLayout` based on the this formats `size`.
     */
    var layout: PDFPageLayout {
        PDFPageLayout(size: self.size,
                      margin: EdgeInsets(top: 60.0, left: 60.0, bottom: 60.0, right: 60.0),
                      space: (header: 15.0, footer: 15.0))
    }
}
