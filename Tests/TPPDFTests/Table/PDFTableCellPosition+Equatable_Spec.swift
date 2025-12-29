//
//  PDFTableCellPosition+Equatable_Spec.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.16.2017.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

import Nimble
import Quick
@testable import TPPDF

class PDFTableCellPosition_Equatable_Spec: QuickSpec {
    override func spec() {
        describe("PDFTableCellPosition") {
            context("Equatable") {
                let position = PDFTableCellPosition(row: 1, column: 2)

                it("is equal") {
                    let otherPosition = PDFTableCellPosition(row: 1, column: 2)
                    expect(position) == otherPosition
                }

                it("is not equal with different row") {
                    let otherPosition = PDFTableCellPosition(row: 2, column: 2)
                    expect(position) != otherPosition
                }

                it("is not equal with different column") {
                    let otherPosition = PDFTableCellPosition(row: 1, column: 3)
                    expect(position) != otherPosition
                }
            }
        }
    }
}
