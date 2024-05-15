//
//  PDFBezierPath+Copying.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 03.06.19.
//

import Foundation

// MARK: - PDFBezierPath + NSCopying

extension PDFBezierPath: NSCopying {
    /// Creates a copy of this path with references to the same vertices
    public func copy(with _: NSZone? = nil) -> Any {
        let path = PDFBezierPath(ref: refFrame)
        path.elements = elements
        return path
    }
}
