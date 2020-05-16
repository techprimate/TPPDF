//
//  PDFTableMergeUtil_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 22.12.19.
//  Copyright © 2019 techprimate GmbH & Co. KG. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import TPPDF

class PDFTableMergeUtilSpec: QuickSpec {

    override func spec() {
        describe("PDFTableMergeUtil") {

            let ROWS = 10
            let COLS = 10

            var table = PDFTable()

            beforeEach {
                table = PDFTable(rows: ROWS, columns: COLS)
                for row in 0..<ROWS {
                    for column in 0..<COLS {
                        table[row, column].content = "\(row),\(column)".asTableContent
                    }
                }
            }

            context("no merging") {

                it("should return a node for each cell") {
                    let result = PDFTableMergeUtil.calculateMerged(table: table)
                    expect(result).to(haveCount(ROWS))
                    for i in 0..<ROWS {
                        expect(result[i]).to(haveCount(COLS))
                    }
                    for row in 0..<ROWS {
                        for col in 0..<COLS {
                            let node = result[row][col]
                            expect(node.cell) === table.cells[row][col]
                            expect(node.moreRowsSpan) == 0
                            expect(node.moreColumnsSpan) == 0
                        }
                    }
                }
            }

            context("with merging") {

                it("should return a node with merged row span") {
                    for row in 0..<ROWS {
                        table[row: row].merge()
                    }
                    let result = PDFTableMergeUtil.calculateMerged(table: table)
                    expect(result).to(haveCount(ROWS))
                    for i in 0..<ROWS {
                        expect(result[i]).to(haveCount(1))
                    }
                    for row in 0..<ROWS {
                        let node = result[row][0]
                        expect(node.cell) === table.cells[row][0]
                        expect(node.moreRowsSpan) == 0
                        expect(node.moreColumnsSpan) == COLS - 1
                    }
                }

                it("should return a node with merged row span") {
                    for index in 0..<COLS {
                        table[column: index].merge()
                    }
                    let result = PDFTableMergeUtil.calculateMerged(table: table)
                    expect(result).to(haveCount(1))
                    for col in 0..<COLS {
                        expect(result[0]).to(haveCount(COLS))
                        let node = result[0][col]
                        expect(node.cell) === table.cells[0][col]
                        expect(node.moreRowsSpan) == ROWS - 1
                        expect(node.moreColumnsSpan) == 0
                    }
                }
            }
        }
    }
}
