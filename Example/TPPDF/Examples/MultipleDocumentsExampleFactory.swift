//
//  MultipleDocumentsExampleFactory.swift
//  TPPDF_Example
//
//  Created by Philip Niedertscheider on 18.12.19.
//  Copyright © 2019 techprimate GmbH & Co. KG. All rights reserved.
//

import Foundation
import TPPDF

class MultipleDocumentsExampleFactory: ExampleFactory {

    func generateDocument() -> [PDFDocument] {
        let document = PDFDocument(format: .a4)
        document.add(text: "This is a my first document!")

        // Create a second document and combine them

        let secondDocument = PDFDocument(format: .a6)
        secondDocument.add(text: "This is a brand new document with a different format!")

        return [document, secondDocument]
    }
}
