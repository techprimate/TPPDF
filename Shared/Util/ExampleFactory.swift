//
//  ExampleFactory.swift
//  TPPDF_Example
//
//  Created by Philip Niedertscheider on 12.12.19.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

import TPPDF

protocol ExampleFactory {
    func generateDocument() -> [PDFDocument]
}
