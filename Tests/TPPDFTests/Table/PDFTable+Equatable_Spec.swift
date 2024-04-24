//
//  PDFTable+Equatable_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 14/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Nimble
import Quick
@testable import TPPDF

class PDFTable_Equatable_Spec: QuickSpec {
    override func spec() {
        describe("PDFTable") {
            context("Equatable") {
                var table: PDFTable!

                beforeEach {
                    table = PDFTable(rows: 0, columns: 0)
                }

                it("is equal") {
                    let otherTable = PDFTable(rows: 0, columns: 0)
                    expect(table) == otherTable
                }

                it("is not equal with different style") {
                    let otherTable = PDFTable(rows: 0, columns: 0)
                    otherTable.style = PDFTableStyle(rowHeaderCount: 2)
                    expect(table) != otherTable
                }

                it("is not equal with different cells") {
                    let otherTable = PDFTable(rows: 0, columns: 0)
                    otherTable.cells = [[PDFTableCell(), PDFTableCell()]]
                    expect(table) != otherTable

                    table.cells = [[PDFTableCell(content: try! PDFTableContent(content: "TEST")), PDFTableCell()]]
                    expect(table) != otherTable
                }

                it("is not equal with different widths") {
                    let otherTable = PDFTable(rows: 0, columns: 0)
                    otherTable.widths = [0.25, 0.75]
                    expect(table) != otherTable
                }

                it("is not equal with different padding") {
                    let otherTable = PDFTable(rows: 0, columns: 0)
                    otherTable.padding = 100
                    expect(table) != otherTable
                }

                it("is not equal with different margin") {
                    let otherTable = PDFTable(rows: 0, columns: 0)
                    otherTable.margin = 100
                    expect(table) != otherTable
                }

                it("is not equal with different showHeadersOnEveryPage") {
                    let otherTable = PDFTable(rows: 0, columns: 0)
                    otherTable.showHeadersOnEveryPage = !table.showHeadersOnEveryPage
                    expect(table) != otherTable
                }
            }
        }
    }
}
