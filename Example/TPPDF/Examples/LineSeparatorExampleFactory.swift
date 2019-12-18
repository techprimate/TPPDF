//
//  LineSeparatorExampleFactory.swift
//  TPPDF_Example
//
//  Created by Philip Niedertscheider on 18.12.19.
//  Copyright © 2019 techprimate GmbH & Co. KG. All rights reserved.
//

import Foundation
import TPPDF

class LineSeparatorExampleFactory: ExampleFactory {

    func generateDocument() -> [PDFDocument] {
        let document = PDFDocument(format: .a4)

        document.add(text: "Text before a separator")
        document.addLineSeparator(style: PDFLineStyle(type: .full, color: UIColor.darkGray, width: 0.5))
        document.add(text: "Text after a separator")
        
        return [document]
    }
}
