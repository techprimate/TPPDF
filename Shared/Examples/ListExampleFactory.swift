//
//  ListExampleFactory.swift
//  TPPDF_Example
//
//  Created by Philip Niedertscheider on 16.12.19.
//  Copyright © 2022 techprimate GmbH. All rights reserved.
//

import TPPDF

class ListExampleFactory: ExampleFactory {

    func generateDocument() -> [PDFDocument] {
        let document = PDFDocument(format: .a4)

        let items = [
            "Simple text drawing",
            "Advanced text drawing using AttributedString",
            "Multi-layer rendering by simply setting the offset",
            "Fully calculated content sizing",
            "Automatic page wrapping",
            "Customizable pagination",
            "Fully editable header and footer",
            "Simple image positioning and rendering",
            "Image captions"
        ]

        // Simple bullet point list
        let featureList = PDFList(indentations: [
            (pre: 10.0, past: 20.0),
            (pre: 20.0, past: 20.0),
            (pre: 40.0, past: 20.0)
        ])

        // By adding the item first to a list item with the dot symbol, all of them will inherit it
        featureList
            .addItem(PDFListItem(symbol: .dot)
                .addItems(items.map({ item in
                    PDFListItem(content: item)
                })))
        document.add(list: featureList)

        document.add(space: 20)
        
        // Simple bullet point list with custom spacing
        let customSpacingList = PDFList(indentations: [
            (pre: 10.0, past: 20.0),
            (pre: 20.0, past: 20.0),
            (pre: 40.0, past: 20.0)
        ])
        
        //A custom spacing can be setup, this property is optional
        customSpacingList.spacing = 16
        
        // By adding the item first to a list item with the dot symbol, all of them will inherit it
        customSpacingList
            .addItem(PDFListItem(symbol: .dot)
                .addItems(items.map({ item in
                    PDFListItem(content: item)
                })))
        document.add(list: customSpacingList)

        document.add(space: 20)


        // Numbered list with unusual indentation
        let weirdIndentationList = PDFList(indentations: [
            (pre: 10.0, past: 20.0),
            (pre: 40.0, past: 30.0),
            (pre: 20.0, past: 50.0)
        ])

        weirdIndentationList
            .addItems(items.enumerated().map({ arg in
                PDFListItem(symbol: .numbered(value: "\(arg.offset + 1)"), content: arg.element)
            }))
        document.add(list: weirdIndentationList)

        return [document]
    }
}
