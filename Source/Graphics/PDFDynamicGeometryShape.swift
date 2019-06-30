//
//  PDFDynamicGeometryShape.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 01.06.19.
//

import Foundation
import UIKit

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
    public var fillColor: UIColor = .black

    /**
     TODO: Documentation
     */
    public var stroke: PDFLineStyle = .none

    /**
     TODO: Documentation
     */
    public init(path: PDFBezierPath, fillColor: UIColor, stroke: PDFLineStyle) {
        self.path = path
        self.fillColor = fillColor
        self.stroke = stroke
    }
}
