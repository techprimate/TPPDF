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

        let table = PDFTable(rows: 50, columns: 4)
        table.widths = [0.1, 0.3, 0.3, 0.3]
        table.style = PDFTableStyleDefaults.none

        for row in 0..<table.size.rows {
            table[row, 0].content = "\(row)".toPDFTableContent()
            for column in 1..<table.size.columns {
                table[row, column].content = "\(row),\(column)".toPDFTableContent()
            }
        }

        for i in stride(from: 0, to: 45, by: 3) {
            table[i...(i + 2), 1].merge(with: PDFTableCell(content: Array(repeating: "\(i),1", count: 3).joined(separator: "\n").toPDFTableContent(),
                                                           alignment: .center))
        }
        for i in stride(from: 1, to: 46, by: 3) {
            table[i...(i + 2), 2].merge(with: PDFTableCell(content: Array(repeating: "\(i),2", count: 3).joined(separator: "\n").toPDFTableContent(),
                                                           alignment: .center))
        }
        for i in stride(from: 2, to: 47, by: 3) {
            table[i...(i + 2), 3].merge(with: PDFTableCell(content: Array(repeating: "\(i),3", count: 3).joined(separator: "\n").toPDFTableContent(),
                                                           alignment: .center))
        }
        //        table[1...3,   1].merge()
        //        table[4...6,   1].merge()
        //        table[7...9,   1].merge()
        //        table[10...12, 1].merge()
        //        table[13...15, 1].merge()

        //        table[2...4,   2].merge()
        //        table[5...7,   2].merge()
        //        table[8...10,  2].merge()
        //        table[11...13, 2].merge()
        //        table[14...15, 2].merge()

        //        table[0...2,   3].merge()
        //        table[3...5,   3].merge()
        //        table[6...8,   3].merge()
        //        table[9...11,  3].merge()
        //        table[12...14, 3].merge()

        document.add(table: table)
        return [document]
    }
}
