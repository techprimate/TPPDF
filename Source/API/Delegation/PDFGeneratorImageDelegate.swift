//
//  PDFGeneratorImageDelegate.swift
//  TPPDF
//
//  Created by Chris Gonzales on 10/10/20.
//

import CoreGraphics

public protocol PDFGeneratorImageDelegate: AnyObject {
    func generator(willBeginDrawingImage image: PDFImage, with context: PDFContext, in frame: CGRect)
}

public extension PDFGeneratorImageDelegate {

    func generator(willBeginDrawingImage image: PDFImage, with context: PDFContext, in frame: CGRect) {}

}
