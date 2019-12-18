//
//  ExperimentFactory.swift
//  TPPDF_Example
//
//  Created by Philip Niedertscheider on 12.12.19.
//  Copyright © 2019 techprimate GmbH & Co. KG. All rights reserved.
//

import TPPDF

class ExperimentFactory: ExampleFactory {

    func generateDocument() -> [PDFDocument] {
        let document1 = PDFDocument(format: .a4)
        for i in 0..<1000 {
            document1.add(text: "DOC 1 - \(i)")
        }

        let document2 = PDFDocument(format: .a5)
        for i in 0..<1000 {
            document2.add(text: "DOC 2 - \(i)")
        }

        return [document1, document2]
    }
}
