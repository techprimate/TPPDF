//
//  PDFTable_RowSubscriptsSpec.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 23.09.20.
//

import Quick
import Nimble
@testable import TPPDF

class PDFTable_RowSubscriptsSpec: QuickSpec {

    override func spec() {
        describe("PDFTable") {
            describe("Row Subscripts") {
                it("should return row by index") {
                    let table = PDFTable(rows: 3, columns: 3)
                    expect(table[row: 1].cells) === table.cells[1]
                }
            }
        }
    }
}
