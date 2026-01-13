//
//  PDFBezierPath+Copying.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 03.06.2019.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
    import UIKit
#else
    import AppKit
#endif

// MARK: - PDFBezierPath + NSCopying

extension PDFBezierPath: NSCopying {
    /// Creates a copy of this path with references to the same vertices
    public func copy(with _: NSZone? = nil) -> Any {
        let path = PDFBezierPath(ref: refFrame)
        path.elements = elements
        return path
    }
}
