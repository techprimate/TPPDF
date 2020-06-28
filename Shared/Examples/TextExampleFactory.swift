//
//  TextExampleFactory.swift
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

class TextExampleFactory: ExampleFactory {

    func generateDocument() -> [PDFDocument] {
        let document = PDFDocument(format: .a4)

        document.set(.contentCenter, font: Font.boldSystemFont(ofSize: 50.0))
        document.set(.contentCenter, textColor: Color(red: 0.171875, green: 0.2421875, blue: 0.3125, alpha: 1.0))
        // Add a string using the title style
        document.add(.contentCenter, textObject: PDFSimpleText(text: "TPPDF"))

        // Add some spacing below title
        document.add(space: 15.0)

        // Create and add a subtitle as an attributed string for more customization possibilities
        let title = NSMutableAttributedString(string: "Create PDF documents easily", attributes: [
            .font: Font.systemFont(ofSize: 18.0),
            .foregroundColor: Color(red: 0.171875, green: 0.2421875, blue: 0.3125, alpha: 1.0)
        ])
        document.add(.contentCenter, attributedText: title)

        // Add some spacing below subtitle
        document.add(space: 10.0)

        // Add headline with extra spacing
        document.add(space: 10)
        document.set(font: Font.systemFont(ofSize: 15))
        document.set(textColor: Color.black)

        document.add(textObject: PDFSimpleText(text: "1. Introduction"))
        document.add(space: 10)

        // Set font for text
        document.set(font: Font.systemFont(ofSize: 13.0))

        // Add long simple text. This will automatically word wrap if content width is not enough.
        document.add(text: "Generating a PDF file using TPPDF feels like a breeze. You can easily setup a document using many convenient commands, and the framework will calculate and render the PDF file at top speed. A small document with 2 pages can be generated in less than 100 milliseconds. A larger document with more complex content, like tables, is still computed in less than a second.")
        document.add(space: 10)

        document.add(text: "TPPDF includes many different features:")
        document.add(space: 10)

        // Add more text after the table
        document.add(text: "Just adding more text here...")

        document.add(space: 50)

        // Set indentation now
        document.set(indent: 50, left: true)
        document.set(indent: 100, left: false)

        // Set font
        document.set(font: Font.systemFont(ofSize: 13))
        document.add(text: LoremIpsum.get(words: 100))

        document.add(space: 300)
        document.add(text: "Test text here")
        
        return [document]
    }
}
