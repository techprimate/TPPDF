//
//  ExternalDocumentExampleFactory.swift
//  TPPDF_Example
//
//  Created by Philip Niedertscheider on 19.12.19.
//  Copyright © 2019 techprimate GmbH & Co. KG. All rights reserved.
//

import Foundation
import TPPDF

class ExternalDocumentExampleFactory: ExampleFactory {

    func generateDocument() -> [PDFDocument] {
        let document = PDFDocument(format: .a4)

        document.add(text: "This is my first document.")

        // Add a PDF page from a different PDF file
        var externalDocument = PDFExternalDocument(url: Bundle.main.url(forResource: "sample", withExtension: "pdf")!, pages: 1, 3)
        document.add(externalDocument: externalDocument)

        // Add more text after externalDocument
        document.add(text: "This is more text after the external pdf file")

        // Add same sample again
        externalDocument = PDFExternalDocument(url: Bundle.main.url(forResource: "sample", withExtension: "pdf")!, pages: 1, 3)
        document.add(externalDocument: externalDocument)

        // Add more text after externalDocument
        document.add(text: "This is the end")

        return [document]
    }
}
