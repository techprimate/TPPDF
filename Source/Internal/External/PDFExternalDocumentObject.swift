//
//  PDFExternalDocumentObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12.08.19.
//

import CoreGraphics
import Foundation

class PDFExternalDocumentObject: PDFRenderObject {
    /// File URL to an external document
    var url: URL
    /// Array of page indicies which should be included from the external document
    var pages: [Int]

    /**
     * Creates a new instance for the given URL
     *
     * - Parameter url: File URL to an external document, see ``PDFExternalDocument/url``
     * - Parameter pages: Array of page indicies which should be included from the external document, see ``PDFExternalDocument/pages``
     */
    init(url: URL, pages: [Int]) {
        self.url = url
        self.pages = pages
    }

    /// nodoc
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [PDFLocatedRenderObject] {
        var result: [PDFLocatedRenderObject] = []

        // Load the PDF document from the defined file URL and split it into individual page objects
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

    /// nodoc
    override var copy: PDFRenderObject {
        PDFExternalDocumentObject(url: url, pages: pages)
    }
}
