//
//  TextStylesExampleFactory.swift
//  TPPDF_Example
//
//  Created by Philip Niedertscheider on 18.12.19.
//  Copyright © 2019 techprimate GmbH & Co. KG. All rights reserved.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif
import TPPDF

class TextStylesExampleFactory: ExampleFactory {

    func generateDocument() -> [PDFDocument] {
        let document = PDFDocument(format: .a4)

        // Define doccument wide styles
        let titleStyle = document.add(style: PDFTextStyle(name: "Title",
                                                          font: Font.boldSystemFont(ofSize: 50.0),
                                                          color: Color(red: 0.171875, green: 0.2421875, blue: 0.3125, alpha: 1.0)))
        let headingStyle1 = document.add(style: PDFTextStyle(name: "Heading 1",
                                                             font: Font.systemFont(ofSize: 20),
                                                             color: Color.black))
        let headingStyle2 = document.add(style: PDFTextStyle(name: "Heading 2",
                                                             font: Font.systemFont(ofSize: 15),
                                                             color: Color.red))

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
