//
//  ExperimentFactory.swift
//  TPPDF_Example
//
//  Created by Philip Niedertscheider on 12.12.19.
//  Copyright © 2019 techprimate GmbH & Co. KG. All rights reserved.
//

import TPPDF

class ExperimentFactory: ExampleFactory {

    func generateDocument() -> [PDFDocument] {
        let document = PDFDocument(format: .a4)

        document.add(space: 100)
        let table = PDFTable(rows: 50, columns: 4)
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

        let singleCellTable = PDFTable(rows: 1, columns: 1)
        singleCellTable[0,0].content = (0...100).map(String.init)
            .joined(separator: "\n")
            .asTableContent
        document.add(table: singleCellTable)

        return [document]
    }
}
