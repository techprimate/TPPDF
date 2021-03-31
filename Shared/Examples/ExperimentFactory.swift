//
//  ExperimentFactory.swift
//  TPPDF_Example
//
//  Created by Philip Niedertscheider on 12.12.19.
//  Copyright © 2019 techprimate GmbH & Co. KG. All rights reserved.
//

import TPPDF
import Foundation

class ExperimentFactory: ExampleFactory {

    func generateDocument() -> [PDFDocument] {
        let document = PDFDocument(format: .a4)

        let items = (0..<40).map { $0.description }

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
