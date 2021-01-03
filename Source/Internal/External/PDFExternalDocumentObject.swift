//
//  PDFExternalDocumentObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12.08.19.
//

import Foundation
import CoreGraphics

internal class PDFExternalDocumentObject: PDFRenderObject {

    internal var url: URL
    internal var pages: [Int]

    internal init(url: URL, pages: [Int]) {
        self.url = url
        self.pages = pages
    }

    override internal func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [PDFLocatedRenderObject] {
        var result: [PDFLocatedRenderObject] = []

        guard let cgPDF = CGPDFDocument(url as CFURL) else {
            throw PDFError.externalDocumentURLInvalid(url: url)
        }
        let allPages = pages.isEmpty ? Array(1...cgPDF.numberOfPages) : pages
        for i in allPages {
            guard let page = cgPDF.page(at: i) else {
                throw PDFError.pageOutOfBounds(index: i)
            }
            result += try PDFExternalPageObject(page: page).calculate(generator: generator, container: container)
        }

        return result
    }

    /**
     TODO: documentation
     */
    override internal var copy: PDFRenderObject {
       PDFExternalDocumentObject(url: self.url, pages: self.pages)
    }
}
