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

    override internal func draw(generator: PDFGenerator, container: PDFContainer, in context: PDFContext) throws {
        if frame != .null {
            context.saveGState()
            context.beginPath()
            context.addPath(BezierPath(rect: frame).cgPath)
            context.clip()
        }
        for child in children {
            try child.draw(generator: generator, container: container, in: context)
        }
        if frame != .null {
            context.restoreGState()
        }
    }
}
