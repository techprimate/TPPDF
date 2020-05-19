//
//  PDFTableCellPosition_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 12/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFTableCellPosition_Spec: QuickSpec {

    override func spec() {
        describe("PDFTableCellPosition") {

            let row = 2
            let column = 5
            let position = PDFTableCellPosition(row: row, column: column)

            context("variables") {

                it("has a row") {
                    expect(position.row).toNot(beNil())
                }

                it("has a column") {
                    expect(position.column).toNot(beNil())
                }
            }

            context("initalizer") {

                it("can be initalized with a row and a column") {
                    expect(position.row) == row
                    expect(position.column) == column
                }
            }

            context("JSONSerializable") {

                it("can be represented") {
                    expect(position.JSONRepresentation as? [String: Int]) == [
                        "row": row,
                        "column": column
                    ]
                }
            }
        }
    }

}
