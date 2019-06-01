//
//  PDFDynamicGeometryShape.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 01.06.19.
//

import Foundation
import UIKit

public class PDFDynamicGeometryShape {

    public var path: PDFBezierPath

    public var fillColor: UIColor = .black

    public var stroke: PDFLineStyle = .none

    public init(path: PDFBezierPath, fillColor: UIColor, stroke: PDFLineStyle) {
        self.path = path
        self.fillColor = fillColor
        self.stroke = stroke
    }
}
