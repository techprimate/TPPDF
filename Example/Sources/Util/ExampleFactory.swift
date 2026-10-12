//
//  ExampleFactory.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12.12.2019.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import TPPDF

protocol ExampleFactory {
    func generateDocument() -> [PDFDocument]
}
