//
//  TableOfContentsExampleFactory.swift
//  TPPDF_Example
//
//  Created by Philip Niedertscheider on 18.12.19.
//  Copyright © 2019 techprimate GmbH & Co. KG. All rights reserved.
//

import Foundation
import TPPDF

class TableOfContentsExampleFactory: ExampleFactory {

    func generateDocument() -> [PDFDocument] {
        let document = PDFDocument(format: .a4)

        // Define doccument wide styles
        let titleStyle = document.add(style: PDFTextStyle(name: "Title",
                                                          font: UIFont.boldSystemFont(ofSize: 50.0),
                                                          color: UIColor(red: 0.171875, green: 0.2421875, blue: 0.3125, alpha: 1.0)))
        let headingStyle1 = document.add(style: PDFTextStyle(name: "Heading 1",
                                                             font: UIFont.systemFont(ofSize: 15),
                                                             color: UIColor.black))
        let headingStyle2 = document.add(style: PDFTextStyle(name: "Heading 2",
                                                             font: UIFont.systemFont(ofSize: 20),
                                                             color: UIColor.red))



        // Add a string using the title style
        document.add(.contentCenter, textObject: PDFSimpleText(text: "TPPDF", style: titleStyle))

        // Add some spacing below title
        document.add(space: 10.0)

        // Create a automatic table of content based on used styles
        document.add(text: "Table of Contents")
        document.add(space: 5.0)

        // Add a table of content, the content will be calculated based on the usages of the styles
        document.add(tableOfContent: PDFTableOfContent(styles: [
            headingStyle1,
            headingStyle2,
        ], symbol: .none))

        // Add headline with extra spacing
        document.add(space: 10)
        document.add(textObject: PDFSimpleText(text: "1. Introduction", style: headingStyle1))
        document.add(space: 10)

        // Set font for text
        document.set(font: UIFont.systemFont(ofSize: 13.0))

        // Add long simple text. This will automatically word wrap if content width is not enough.
        document.add(text: "Generating a PDF file using TPPDF feels like a breeze. You can easily setup a document using many convenient commands, and the framework will calculate and render the PDF file at top speed. A small document with 2 pages can be generated in less than 100 milliseconds. A larger document with more complex content, like tables, is still computed in less than a second.")
        document.add(space: 10)

        document.add(text: "TPPDF includes many different features:")
        document.add(space: 10)

        document.add(space: 10)
        document.add(textObject: PDFSimpleText(text: "2. Images", style: headingStyle1))
        document.add(space: 10)

        document.add(text: "It does support images! Checkout the image example!")

        document.add(space: 10)
        document.add(textObject: PDFSimpleText(text: "3. Tables", style: headingStyle1))
        document.add(space: 10)

        document.add(text: "Creating tables is a breeze!")
        
        return [document]
    }
}
