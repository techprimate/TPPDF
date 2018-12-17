//
//  PDFTable_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 16/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFTable_Spec: QuickSpec {

    override func spec() {
        describe("PDFTable") {

            context("variables") {

                let table = PDFTable()

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

            context("cell generation") {

                var table: PDFTable!

                beforeEach {
                    table = PDFTable()
                }

                it("will throw if data is invalid") {
                    let data = [["EXAMPLE"]]
                    let alignments: [[PDFTableCellAlignment]] = []

                    expect {
                        try table.generateCells(data: data, alignments: alignments)
                    }.to(throwError())
                }

                it("does generate cells based on data and alignements") {
                    let data = [
                        ["1|1", "1|2", "1|3"],
                        ["2|1", "2|2", "2|3"]
                    ]

                    let alignments = [
                        [PDFTableCellAlignment.left, PDFTableCellAlignment.center, PDFTableCellAlignment.right],
                        [PDFTableCellAlignment.right, PDFTableCellAlignment.bottom, PDFTableCellAlignment.left]
                    ]

                    expect {
                        try table.generateCells(data: data, alignments: alignments)
                        }.toNot(throwError())

                    let resultContent = [
                        [try! PDFTableContent(content: "1|1"), try! PDFTableContent(content: "1|2"), try! PDFTableContent(content: "1|3")],
                        [try! PDFTableContent(content: "2|1"), try! PDFTableContent(content: "2|2"), try! PDFTableContent(content: "2|3")]
                    ]
                    let result = [
                        [
                            PDFTableCell(content: resultContent[0][0], alignment: alignments[0][0], style: nil),
                            PDFTableCell(content: resultContent[0][1], alignment: alignments[0][1], style: nil),
                            PDFTableCell(content: resultContent[0][2], alignment: alignments[0][2], style: nil)
                        ],
                        [
                            PDFTableCell(content: resultContent[1][0], alignment: alignments[1][0], style: nil),
                            PDFTableCell(content: resultContent[1][1], alignment: alignments[1][1], style: nil),
                            PDFTableCell(content: resultContent[1][2], alignment: alignments[1][2], style: nil)
                        ]
                    ]
                    expect(table.cells.count) == result.count
                    expect(table.cells[0]) == result[0]
                    expect(table.cells[1]) == result[1]
                }
            }

            context("cell style") {

                it("can not set style of row out of bounds") {
                    let table = PDFTable()

                    expect {
                        try table.setCellStyle(row: 1, column: 2, style: nil)
                        }.to(throwError(PDFError.tableIndexOutOfBounds(index: 1, length: 0)))

                    expect {
                        try table.setCellStyle(row: -1, column: 2, style: nil)
                        }.to(throwError(PDFError.tableIndexOutOfBounds(index: -1, length: 0)))
                }

                it("can not set style of column out of bounds") {
                    let table = PDFTable()
                    table.cells = [[]]

                    expect {
                        try table.setCellStyle(row: 0, column: 1, style: nil)
                        }.to(throwError(PDFError.tableIndexOutOfBounds(index: 1, length: 0)))

                    expect {
                        try table.setCellStyle(row: 0, column: -1, style: nil)
                        }.to(throwError(PDFError.tableIndexOutOfBounds(index: -1, length: 0)))
                }

                it("can set style of cell") {
                    let table = PDFTable()
                    table.cells = [[PDFTableCell()]]

                    let style = PDFTableCellStyle(colors: (fill: UIColor.green, text: UIColor.orange))

                    expect {
                        try table.setCellStyle(row: 0, column: 0, style: style)
                    }.toNot(throwError())

                    expect(table.cells[0][0].style).toEventually(equal(style))

                }
            }
        }
    }

}
