//
//  ListExampleFactory.swift
//  TPPDF_Example
//
//  Created by Philip Niedertscheider on 16.12.19.
//  Copyright © 2019 techprimate GmbH & Co. KG. All rights reserved.
//

import TPPDF

class ListExampleFactory: ExampleFactory {

    func generateDocument() -> [PDFDocument] {
        let document = PDFDocument(format: .a4)

        // Simple bullet point list
        let featureList = PDFList(indentations: [
            (pre: 10.0, past: 20.0),
            (pre: 20.0, past: 20.0),
            (pre: 40.0, past: 20.0)
        ])

        featureList.addItem(PDFListItem(symbol: .dot)
            .addItems([
                PDFListItem(content: "Simple text drawing"),
                PDFListItem(content: "Advanced text drawing using AttributedString"),
                PDFListItem(content: "Multi-layer rendering by simply setting the offset"),
                PDFListItem(content: "Fully calculated content sizing"),
                PDFListItem(content: "Automatic page wrapping"),
                PDFListItem(content: "Customizable pagination"),
                PDFListItem(content: "Fully editable header and footer"),
                PDFListItem(content: "Simple image positioning and rendering"),
                PDFListItem(content: "Image captions")
            ]))
        document.add(list: featureList)
        return [document]
    }
}
