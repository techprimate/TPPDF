//
//  PDFTableValidator_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 16/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFTableValidator_Spec: QuickSpec {

    override func spec() {
        describe("PDFTableValidator") {

            let data = [
                [
                    "1|1",
                    "1|2",
                    "1|3",
                    "1|4"
                ],
                [
                    "2|1",
                    "2|2",
                    "2|3",
                    "2|4"
                ]
            ]
            let alignments = [
                [
                    PDFTableCellAlignment.left,
                    PDFTableCellAlignment.top,
                    PDFTableCellAlignment.right,
                    PDFTableCellAlignment.bottom
                ],
                [
                    PDFTableCellAlignment.topLeft,
                    PDFTableCellAlignment.topRight,
                    PDFTableCellAlignment.bottomRight,
                    PDFTableCellAlignment.bottomLeft
                ]
            ]
            let widths: [CGFloat] = [
                0.1,
                0.2,
                0.3,
                0.4
            ]

            var table: PDFTable!

            beforeEach {
                table = PDFTable()
            }

            context("table validation") {

                it("fails when no cells in table") {
                    expect {
                        try PDFTableValidator.validateTable(table: table)
                        }.to(throwError(PDFError.tableIsEmpty))
                }

                it("fails when not same amount of data than widths") {
                    table.widths = widths
                    try! table.generateCells(data: data, alignments: alignments)
                    table.widths = []

                    expect {
                        try PDFTableValidator.validateTable(table: table)
                        }.to(throwError(
                            PDFError.tableStructureInvalid(message: "Data and alignment for row with index 0 does not have the same amount!")
                        ))
                }

                it("should not fail with valid data") {
                    table.widths = widths
                    try! table.generateCells(data: data, alignments: alignments)

                    expect {
                        try PDFTableValidator.validateTable(table: table)
                        }.toNot(throwError())
                }
            }

            context("data validation") {

                it("fails when no data given") {
                    expect {
                        try PDFTableValidator.validateTableData(data: [])
                        }.to(throwError(PDFError.tableIsEmpty))
                }

                it("fails when alignments not given and count not same") {
                    expect {
                        try PDFTableValidator.validateTableData(data: data, alignments: [])
                        }.to(throwError(
                            PDFError.tableStructureInvalid(message: "Data and alignment must be equal size!")
                        ))
                }

                it("fails when data row and alignment row is not the same") {
                    expect {
                        try PDFTableValidator.validateTableData(data: data, alignments: [[], []])
                        }.to(throwError(
                            PDFError.tableStructureInvalid(message: "Data and alignment for row with index 0 does not have the same amount!")
                        ))
                }

                it("fails when data row and column widths count is not the same") {
                    expect {
                        try PDFTableValidator.validateTableData(data: data, alignments: nil, columnWidths: [])
                        }.to(throwError(
                            PDFError.tableStructureInvalid(message: "Data and alignment for row with index 0 does not have the same amount!")
                        ))
                }
            }
        }
    }

}
