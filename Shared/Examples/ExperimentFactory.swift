//
//  ExperimentFactory.swift
//  TPPDF_Example
//
//  Created by Philip Niedertscheider on 12.12.19.
//  Copyright © 2019 techprimate GmbH & Co. KG. All rights reserved.
//

import TPPDF
import Foundation

class ExperimentFactory: ExampleFactory {

    func generateDocument() -> [PDFDocument] {
        let document = PDFDocument(format: .a4)

        document.pagination = .init(container: .footerRight)
        
        let externalDocument = PDFExternalDocument(url: Bundle.main.url(forResource: "sample-large", withExtension: "pdf")!)
        document.add(externalDocument: externalDocument)

        document.add(text: "END")

        return [document]
    }
}
