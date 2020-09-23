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

        let table = PDFTable(rows: 3, columns: 4)
        table.content = [
            ["0,0", "0,1", "0,2", "0,3"],
            ["1,0", "1,1", "1,2", "1,3"],
            ["2,0", "2,1", "2,2", "2,3"],
        ]
        table.rows.allRowsAlignment = [.left, .left, .right, .right]
        document.add(table: table)

        return [document]
    }
}
