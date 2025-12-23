//
//  ExperimentFactory.swift
//  TPPDF_Example
//
//  Created by Philip Niedertscheider on 12.12.19.
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
