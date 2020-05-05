//
//  PDFSlicedObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 06.01.20.
//

import UIKit

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
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        if frame != .null {
            context.saveGState()
            UIBezierPath(rect: frame).addClip()
        }
        for child in children {
            try child.draw(generator: generator, container: container)
        }
        if frame != .null {
            context.restoreGState()
        }
    }
}
