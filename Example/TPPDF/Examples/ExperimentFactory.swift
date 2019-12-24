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

        let table = PDFTable(rows: 16, columns: 3)
        table.style = PDFTableStyleDefaults.none

        for row in 0..<table.size.rows {
            for column in 0..<table.size.columns {
                table[row, column].content = Array(repeating: "\(row),\(column)", count: 5).joined(separator: "\n").toPDFTableContent()
            }
        }

        table[1...3,   0].merge()
        table[4...6,   0].merge()
        table[7...9,   0].merge()
        table[10...12, 0].merge()
        table[13...15, 0].merge()

        table[2...4,   1].merge()
        table[5...7,   1].merge()
        table[8...10,  1].merge()
        table[11...13, 1].merge()
        table[14...15, 1].merge()

        table[1...2,   2].merge()
        table[3...5,   2].merge()
        table[6...8,   2].merge()
        table[9...11,  2].merge()
        table[12...14, 2].merge()

        document.add(table: table)
        return [document]
    }
}
