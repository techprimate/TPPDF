//
//  PDFTableCellBorders+Equatable_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 16/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFTableCellBorders_Equatable_Spec: QuickSpec {

    override func spec() {
        describe("PDFTableCellBorders") {

            context("Equatable") {

                let style = PDFLineStyle(type: .dotted, color: .orange, width: 10)
                let borders = PDFTableCellBorders()

                it("is equal") {
                    let otherBorders = PDFTableCellBorders()
                    expect(borders) == otherBorders
                }

                it("is not equal with different left") {
                    let otherBorders = PDFTableCellBorders(left: style)
                    expect(borders) != otherBorders
                }

                it("is not equal with different top") {
                    let otherBorders = PDFTableCellBorders(top: style)
                    expect(borders) != otherBorders
                }

                it("is not equal with different right") {
                    let otherBorders = PDFTableCellBorders(right: style)
                    expect(borders) != otherBorders
                }

                it("is not equal with different bottom") {
                    let otherBorders = PDFTableCellBorders(bottom: style)
                    expect(borders) != otherBorders
                }
            }
        }
    }

}
