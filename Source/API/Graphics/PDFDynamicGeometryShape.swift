//
//  PDFDynamicGeometryShape.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 01.06.19.
//

#if os(iOS) || os(visionOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

/// Renders an arbitrary path into the graphics context
public class PDFDynamicGeometryShape: CustomStringConvertible {
    /// Path of the geometry shape
    public var path: PDFBezierPath

    /// Color used to fill the shape
    public var fillColor: Color = .black

    /// Line style used to stroke the shape
    public var stroke: PDFLineStyle = .none

    /**
     * Creates a new dynamic geometry shape
     *
     * - Parameters:
     *    - path: See ``PDFDynamicGeometryShape/path`
     *    - fillColor: See ``PDFDynamicGeometryShape/fillColor`
     *    - strolke: See ``PDFDynamicGeometryShape/stroke`
     */
    public init(path: PDFBezierPath, fillColor: Color, stroke: PDFLineStyle) {
        self.path = path
        self.fillColor = fillColor
        self.stroke = stroke
    }
}
