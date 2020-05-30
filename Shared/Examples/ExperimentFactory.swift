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
        table.shouldSplitCellsOnPageBeak = false
        table.style.columnHeaderCount = 3

        for row in 0..<table.size.rows {
            table[row, 0].content = "\(row)".asTableContent
            for column in 1..<table.size.columns {
                table[row, column].content = "\(row),\(column)".asTableContent
            }
        }

        document.add(table: table)

        let singleCellTable = PDFTable(rows: 1, columns: 1)
        singleCellTable[0,0].content = (0...100).map(String.init)
            .joined(separator: "\n")
            .asTableContent
        document.add(table: singleCellTable)

        return [document]
    }
}
