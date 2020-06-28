//
//  PDFBezierPath+Copying.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 03.06.19.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/**
 TODO: Documentation
 */
extension PDFBezierPath: NSCopying {

    /**
     TODO: Documentation
     */
    public func copy(with zone: NSZone? = nil) -> Any {
        let path = PDFBezierPath(ref: self.refFrame)
        path.elements = self.elements
        return path
    }
}
