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
        [
            (container, self)
        ]
    }

    override internal func draw(generator: PDFGenerator, container: PDFContainer, in context: CGContext) throws {
        let mediaBox = page.getBoxRect(.mediaBox)
        #if os(iOS)
        UIGraphicsBeginPDFPageWithInfo(mediaBox, nil)
        #elseif os(macOS)
        context.beginPDFPage(nil)
        #endif

        context.saveGState()
        context.translateBy(x: 0, y: mediaBox.size.height)
        context.scaleBy(x: 1, y: -1)

        context.drawPDFPage(page)

        context.restoreGState()

        applyAttributes(in: context)
    }
}
