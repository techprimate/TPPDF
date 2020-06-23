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
        print(#file, #line, "End PDF Page")
        context.endPDFPage()
        print(#file, #line, "Begin PDF Page")
        context.beginPDFPage(nil)
        #endif

        context.saveGState()
        context.drawPDFPage(page)
        context.restoreGState()

        applyAttributes(in: context)
    }
}
