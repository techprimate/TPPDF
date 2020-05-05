//
//  HeaderFooterExampleFactory.swift
//  TPPDF_Example
//
//  Created by Philip Niedertscheider on 18.12.19.
//  Copyright © 2019 techprimate GmbH & Co. KG. All rights reserved.
//

import Foundation
import TPPDF

class HeaderFooterExampleFactory: ExampleFactory {

    func generateDocument() -> [PDFDocument] {
        let document = PDFDocument(format: .a4)

        // Add text to footer

        document.add(.footerLeft, textObject: PDFSimpleText(text: "Footer Left 1"))
        document.add(.footerLeft, textObject: PDFSimpleText(text: "Footer Left 2"))
        document.add(.footerLeft, textObject: PDFSimpleText(text: "Footer Left 3"))

        document.add(.footerRight, textObject: PDFSimpleText(text: "Footer Right 1"))
        document.add(.footerRight, textObject: PDFSimpleText(text: "Footer Right 2"))
        document.add(.footerRight, textObject: PDFSimpleText(text: "Footer Right 3"))

        // Add text to header

        document.add(.headerLeft, textObject: PDFSimpleText(text: "Header Left 1"))
        document.add(.headerLeft, textObject: PDFSimpleText(text: "Header Left 2"))
        document.add(.headerLeft, textObject: PDFSimpleText(text: "Header Left 3"))

        document.add(.headerRight, textObject: PDFSimpleText(text: "Header Right 1"))
        document.add(.headerRight, textObject: PDFSimpleText(text: "Header Right 2"))
        document.add(.headerRight, textObject: PDFSimpleText(text: "Header Right 3"))


        document.add(text: "Random text, otherwise the headers and footers won't be visible")
        
        return [document]
    }
}
