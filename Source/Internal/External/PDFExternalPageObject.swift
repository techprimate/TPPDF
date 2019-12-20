//
//  PDFExternalPageObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12.08.19.
//

import Foundation

internal class PDFExternalPageObject: PDFRenderObject {

    internal var page: CGPDFPage

    internal init(page: CGPDFPage) {
        self.page = page
    }

    override internal func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFRenderObject)] {
        return [(container, self)]
    }

    override internal func draw(generator: PDFGenerator, container: PDFContainer) throws {
        let mediaBox = page.getBoxRect(.mediaBox)
        UIGraphicsBeginPDFPageWithInfo(mediaBox, nil)

        guard let context = UIGraphicsGetCurrentContext() else {
            fatalError()
        }

        context.saveGState()
        context.translateBy(x: 0, y: mediaBox.size.height)
        context.scaleBy(x: 1, y: -1)

        context.drawPDFPage(page)

        context.restoreGState()

        applyAttributes()
    }
}
