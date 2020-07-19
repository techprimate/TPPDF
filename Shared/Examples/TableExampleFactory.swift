//
//  TableExampleFactory.swift
//  TPPDF_Example
//
//  Created by Philip Niedertscheider on 16.12.19.
//  Copyright © 2019 techprimate GmbH & Co. KG. All rights reserved.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

import TPPDF

class TableExampleFactory: ExampleFactory {

    func generateDocument() -> [PDFDocument] {
        let document = PDFDocument(format: .a4)

        // Create a table
        var table = PDFTable(rows: 10, columns: 4)

        // Tables can contain Strings, Numbers, Images or nil, in case you need an empty cell.
        // If you add a unknown content type, an assertion will be thrown and the rendering will stop.
        table.content = [
            [nil, "Name",      "Image",                        "Description"],
            [1,   "Waterfall", Image(named: "Image-1.jpg")!, "Water flowing down stones."],
            [2,   "Forrest",   Image(named: "Image-2.jpg")!, "Sunlight shining through the leafs."],
            [3,   "Fireworks", Image(named: "Image-3.jpg")!, "Fireworks exploding into 100.000 stars"],
            [4,   "Fields",    Image(named: "Image-4.jpg")!, "Crops growing big and providing food."],
            [1,   "Waterfall", Image(named: "Image-1.jpg")!, "Water flowing down stones."],
            [2,   "Forrest",   Image(named: "Image-2.jpg")!, "Sunlight shining through the leafs."],
            [3,   "Fireworks", Image(named: "Image-3.jpg")!, "Fireworks exploding into 100.000 stars"],
            [4,   "Fields",    Image(named: "Image-4.jpg")!, "Crops growing big and providing food."],
            [nil, nil,         nil,                            "Many beautiful places"]
        ]
        table.rows.allRowsAlignment = [.center, .left, .center, .right]

        // The widths of each column is proportional to the total width, set by a value between 0.0 and 1.0, representing percentage.

        table.widths = [
            0.1, 0.25, 0.35, 0.3
        ]

        // To speed up table styling, use a default and change it

        let style = PDFTableStyleDefaults.simple

        // Change standardized styles
        style.footerStyle = PDFTableCellStyle(
            colors: (
                fill: Color(red: 0.171875,
                              green: 0.2421875,
                              blue: 0.3125,
                              alpha: 1.0),
                text: Color.white
            ),
            borders: PDFTableCellBorders(left: PDFLineStyle(type: .full),
                                         top: PDFLineStyle(type: .full),
                                         right: PDFLineStyle(type: .full),
                                         bottom: PDFLineStyle(type: .full)),

            font: Font.systemFont(ofSize: 10)
        )

        // Simply set the amount of footer and header rows

        style.columnHeaderCount = 1
        style.footerCount = 1

        table.style = style

        // Style each cell individually
        table[1,1].style = PDFTableCellStyle(colors: (fill: Color.yellow, text: Color.black))

        // Set table padding and margin
        table.padding = 5.0
        table.margin = 10.0

        // In case of a linebreak during rendering we want to have table headers on each page.

        table.showHeadersOnEveryPage = true

        document.add(table: table)

        // Another table:

        table = PDFTable(rows: 50, columns: 4)
        table.widths = [0.1, 0.3, 0.3, 0.3]
        table.margin = 10
        table.padding = 10
        table.showHeadersOnEveryPage = false
        table.style.columnHeaderCount = 3

        for row in 0..<table.size.rows {
            table[row, 0].content = "\(row)".asTableContent
            for column in 1..<table.size.columns {
                table[row, column].content = "\(row),\(column)".asTableContent
            }
        }

        for i in stride(from: 3, to: 48, by: 3) {
            table[rows: i...(i + 2), column: 1].merge(with: PDFTableCell(content: Array(repeating: "\(i),1", count: 3).joined(separator: "\n").asTableContent,
                                                           alignment: .center))
        }
        for i in stride(from: 4, to: 47, by: 3) {
            table[rows: i...(i + 2), column: 2].merge(with: PDFTableCell(content: Array(repeating: "\(i),2", count: 3).joined(separator: "\n").asTableContent,
                                                           alignment: .center))
        }
        for i in stride(from: 5, to: 48, by: 3) {
            table[rows: i...(i + 2), column: 3].merge(with: PDFTableCell(content: Array(repeating: "\(i),3", count: 3).joined(separator: "\n").asTableContent,
                                                           alignment: .center))
        }

        table[rows: 0..<2, column: 2].merge()
        table[rows: 1..<3, column: 3].merge()

        document.add(table: table)

        return [document]
    }
}
