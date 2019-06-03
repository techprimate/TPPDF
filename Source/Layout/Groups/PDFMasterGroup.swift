//
//  PDFMasterGroup.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 31.05.19.
//

import Foundation

public class PDFMasterGroup: PDFGroup {

    public init() {
        super.init(allowsBreaks: false)
    }

    public func setMargin(left: CGFloat? = nil, right: CGFloat? = nil, top: CGFloat? = nil, bottom: CGFloat? = nil) {
        objects += [(.none, PDFMarginObject(left: left, right: right, top: top, bottom: bottom))]
    }

    public func resetMargin() {
        objects += [(.none, PDFMarginObject(reset: true))]
    }
}
