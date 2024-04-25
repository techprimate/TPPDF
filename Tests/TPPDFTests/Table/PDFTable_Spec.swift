//
//  PDFTable_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 16/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Nimble
import Quick
@testable import TPPDF

class PDFTable_Spec: QuickSpec {
    override func spec() {
        describe("PDFTable") {
            context("variables") {
                let table = PDFTable(rows: 0, columns: 0)

                it("has a default style") {
                    expect(table.style) == PDFTableStyleDefaults.simple
                }

                it("has no default cells") {
                    expect(table.cells.isEmpty).to(beTrue())
                }

                it("hsa no default widths") {
                    expect(table.widths) == []
                }

                it("has a default padding") {
                    expect(table.padding) == 0
                }

                it("has a default margin") {
                    expect(table.margin) == 0
                }

                it("has a default showHeadersOnEveryPage") {
                    expect(table.showHeadersOnEveryPage).to(beFalse())
                }
            }

            context("cell style") {
                it("can set style of cell") {
                    let table = PDFTable(rows: 0, columns: 0)
                    table.cells = [[PDFTableCell()]]

                    let style = PDFTableCellStyle(colors: (fill: Color.green, text: Color.orange))

                    table[0, 0].style = style
                    expect(table.cells[0][0].style).toEventually(equal(style))
                }
            }
        }
    }
}
