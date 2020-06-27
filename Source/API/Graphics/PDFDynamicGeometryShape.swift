//
//  PDFDynamicGeometryShape.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 01.06.19.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/**
 TODO: Documentation
 */
public class PDFDynamicGeometryShape: CustomStringConvertible {

    /**
     TODO: Documentation
     */
    public var path: PDFBezierPath

    /**
     TODO: Documentation
     */
    public var fillColor: Color = .black

    /**
     TODO: Documentation
     */
    public var stroke: PDFLineStyle = .none

    /**
     TODO: Documentation
     */
    public init(path: PDFBezierPath, fillColor: Color, stroke: PDFLineStyle) {
        self.path = path
        self.fillColor = fillColor
        self.stroke = stroke
    }
}
