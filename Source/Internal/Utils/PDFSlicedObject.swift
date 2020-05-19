//
//  PDFSlicedObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 06.01.20.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif
import CoreGraphics

internal class PDFSlicedObject: PDFRenderObject {

    internal var children: [PDFRenderObject]

    internal init(children: [PDFRenderObject] = [], frame: CGRect = .null) {
        self.children = children
        super.init()
        self.frame = frame
    }

    override internal func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [PDFLocatedRenderObject] {
        [
            (container, self)
        ]
    }

    override internal func draw(generator: PDFGenerator, container: PDFContainer) throws {
        #if os(iOS)
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        #else
        guard let context = NSGraphicsContext.current?.cgContext else {
            return
        }
        #endif
        if frame != .null {
            context.saveGState()
            BezierPath(rect: frame).addClip()
        }
        for child in children {
            try child.draw(generator: generator, container: container)
        }
        if frame != .null {
            context.restoreGState()
        }
    }
}
