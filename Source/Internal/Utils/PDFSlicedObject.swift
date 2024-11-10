//
//  PDFSlicedObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 06.01.20.
//

#if os(iOS) || os(visionOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif
import CoreGraphics

class PDFSlicedObject: PDFRenderObject {
    var children: [PDFRenderObject]

    init(children: [PDFRenderObject] = [], frame: CGRect = .null) {
        self.children = children
        super.init()
        self.frame = frame
    }

    override func calculate(generator _: PDFGenerator, container: PDFContainer) throws -> [PDFLocatedRenderObject] {
        [
            (container, self),
        ]
    }

    override func draw(generator: PDFGenerator, container: PDFContainer, in context: PDFContext) throws {
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
