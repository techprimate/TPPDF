//
//  TextStylesExampleFactory.swift
//  TPPDF_Example
//
//  Created by Philip Niedertscheider on 18.12.19.
//  Copyright © 2019 techprimate GmbH & Co. KG. All rights reserved.
//

import UIKit
import TPPDF

class TextStylesExampleFactory: ExampleFactory {

    func generateDocument() -> [PDFDocument] {
        let document = PDFDocument(format: .a4)

        // Define doccument wide styles
        let titleStyle = document.add(style: PDFTextStyle(name: "Title",
                                                          font: UIFont.boldSystemFont(ofSize: 50.0),
                                                          color: UIColor(red: 0.171875, green: 0.2421875, blue: 0.3125, alpha: 1.0)))
        let headingStyle1 = document.add(style: PDFTextStyle(name: "Heading 1",
                                                             font: UIFont.systemFont(ofSize: 20),
                                                             color: UIColor.black))
        let headingStyle2 = document.add(style: PDFTextStyle(name: "Heading 2",
                                                             font: UIFont.systemFont(ofSize: 15),
                                                             color: UIColor.red))

        document.add(textObject: PDFSimpleText(text: "TPPDF", style: titleStyle))

        document.add(textObject: PDFSimpleText(text: "1. Heading", style: headingStyle1))
        document.add(text: LoremIpsum.get(words: 30))

        document.add(textObject: PDFSimpleText(text: "1.1 Heading", style: headingStyle2))
        document.add(text: LoremIpsum.get(words: 30))

        document.add(textObject: PDFSimpleText(text: "2. Heading", style: headingStyle1))
        document.add(text: LoremIpsum.get(words: 30))

        return [document]
    }
}
