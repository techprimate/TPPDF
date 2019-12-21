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

        let table = PDFTable(rows: 5, columns: 5)

        for row in 0..<table.size.rows {
            for column in 0..<table.size.columns {
                table[row, column].content = "\(row),\(column)".toPDFTableContent()
            }
        }
        table[0...1, 0...3].merge()

        document.add(table: table)
        return [document]
    }
}
