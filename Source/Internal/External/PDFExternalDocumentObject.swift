//
//  PDFExternalDocumentObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12.08.19.
//

import CoreGraphics
import Foundation

class PDFExternalDocumentObject: PDFRenderObject {
    var url: URL
    var pages: [Int]

    init(url: URL, pages: [Int]) {
        self.url = url
        self.pages = pages
    }

    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [PDFLocatedRenderObject] {
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
    override var copy: PDFRenderObject {
        PDFExternalDocumentObject(url: url, pages: pages)
    }
}
