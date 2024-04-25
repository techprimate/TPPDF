//
//  PDFGeneratorImageDelegate.swift
//  TPPDF
//
//  Created by Chris Gonzales on 10/10/20.
//

import CoreGraphics

/// Protocol used to delegate drawing of images
public protocol PDFGeneratorImageDelegate: AnyObject {
    /**
     * Called directly before a ``PDFImage`` is drawn into the graphics context
     *
     * As the `image` is a reference object, it is possible to read and manipulate the object before rendering.
     *
     * One use-case could be overlaying the ``PDFImage/image`` with a watermark, after it final frame is calculated.
     */
    func generator(willBeginDrawingImage image: PDFImage, with context: PDFContext, in frame: CGRect)
}
