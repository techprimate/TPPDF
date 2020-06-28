//
//  PDFMasterGroup.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 31.05.19.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/**
 TODO: Documentation
 */
public class PDFMasterGroup: PDFGroup {

    public var isFullPage: Bool

    /**
     TODO: Documentation
     */
    public init(isFullPage: Bool = false) {
        self.isFullPage = isFullPage
        super.init(allowsBreaks: false)
    }

    /**
     TODO: Documentation
     */
    public func setMargin(left: CGFloat? = nil, right: CGFloat? = nil, top: CGFloat? = nil, bottom: CGFloat? = nil) {
        objects += [(.none, PDFMarginObject(left: left, right: right, top: top, bottom: bottom))]
    }

    /**
     TODO: Documentation
     */
    public func resetMargin() {
        objects += [(.none, PDFMarginObject(reset: true))]
    }
}
