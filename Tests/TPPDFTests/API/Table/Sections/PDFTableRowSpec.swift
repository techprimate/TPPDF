//
//  PDFTableRowSpec.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 23.09.20.
//

import Quick
import Nimble
@testable import TPPDF

class PDFTableRowSpec: QuickSpec {

    override func spec() {
        describe("PDFTableRow") {
            describe("alignment") {
                it("should set alignment for each row the same") {
                    let table = PDFTable(rows: 3, columns: 3)
                    table.rows.allRowsAlignment = [.left, .center, .right]
                    expect(table.rows.alignment) == [
                        [.left, .center, .right],
                        [.left, .center, .right],
                        [.left, .center, .right]
                    ]
                }
            }
        }
    }
}

