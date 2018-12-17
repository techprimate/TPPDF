//
//  PDFTable+Equatable_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 14/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFTable_Equatable_Spec: QuickSpec {

    override func spec() {
        describe("PDFTable") {

            context("Equatable") {

                var table: PDFTable!

                beforeEach {
                    table = PDFTable()
                }

                it("is equal") {
                    let otherTable = PDFTable()
                    expect(table) == otherTable
                }

                it("is not equal with different style") {
                    let otherTable = PDFTable()
                    otherTable.style = PDFTableStyle(rowHeaderCount: 2)
                    expect(table) != otherTable
                }

                it("is not equal with different cells") {
                    let otherTable = PDFTable()
                    otherTable.cells = [[PDFTableCell(), PDFTableCell()]]
                    expect(table) != otherTable

                    table.cells = [[PDFTableCell(content: try! PDFTableContent(content: "TEST")), PDFTableCell()]]
                    expect(table) != otherTable
                }

                it("is not equal with different widths") {
                    let otherTable = PDFTable()
                    otherTable.widths = [0.25, 0.75]
                    expect(table) != otherTable
                }

                it("is not equal with different padding") {
                    let otherTable = PDFTable()
                    otherTable.padding = 100
                    expect(table) != otherTable
                }

                it("is not equal with different margin") {
                    let otherTable = PDFTable()
                    otherTable.margin = 100
                    expect(table) != otherTable
                }

                it("is not equal with different showHeadersOnEveryPage") {
                    let otherTable = PDFTable()
                    otherTable.showHeadersOnEveryPage = !table.showHeadersOnEveryPage
                    expect(table) != otherTable
                }
            }
        }
    }

}
