//
//  PDFExternalPageObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12.08.19.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

internal class PDFExternalPageObject: PDFRenderObject {

    internal var page: CGPDFPage

    internal init(page: CGPDFPage) {
        self.page = page
    }

    override internal func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [PDFLocatedRenderObject] {
        self.frame = page.getBoxRect(.mediaBox)
        return [
            (container, self)
        ]
    }

    override internal func draw(generator: PDFGenerator, container: PDFContainer, in context: CGContext) throws {
        PDFContextGraphics.endPDFPage(in: context)
        PDFContextGraphics.beginPDFPage(in: context, for: frame, flipped: false)

        context.saveGState()
        context.drawPDFPage(page)
        context.restoreGState()

        applyAttributes(in: context)
    }
}
