//
//  ExperimentFactory.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12.12.2019.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

import Foundation
import TPPDF

class ExperimentFactory: ExampleFactory {
    func generateDocument() -> [PDFDocument] {
        let document = PDFDocument(format: .b5)

        // Create custom documents to experiment with the framework

        return [document]
    }
}
