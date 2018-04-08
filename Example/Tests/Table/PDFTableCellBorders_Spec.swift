//
//  PDFTableCellBorders_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 16/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFTableCellBorders_Spec: QuickSpec {

    override func spec() {
        describe("PDFTableCellBorders") {

            context("variables") {

                let borders = PDFTableCellBorders()

                it("has default left border") {
                    expect(borders.left) == PDFLineStyle.none
                }

                it("has default top border") {
                    expect(borders.top) == PDFLineStyle.none
                }

                it("has a default right border") {
                    expect(borders.right) == PDFLineStyle.none
                }

                it("has a default bottom border") {
                    expect(borders.bottom) == PDFLineStyle.none
                }
            }

            context("initalizer") {

                it("can be iniatlized with a left border") {
                    let style = PDFLineStyle(type: .dotted, color: .orange, width: 10)
                    let borders = PDFTableCellBorders(left: style)

                    expect(borders.left) == style
                }

                it("can be iniatlized with a top border") {
                    let style = PDFLineStyle(type: .dotted, color: .orange, width: 10)
                    let borders = PDFTableCellBorders(top: style)

                    expect(borders.top) == style
                }

                it("can be iniatlized with a right border") {
                    let style = PDFLineStyle(type: .dotted, color: .orange, width: 10)
                    let borders = PDFTableCellBorders(right: style)

                    expect(borders.right) == style
                }

                it("can be iniatlized with a bottom border") {
                    let style = PDFLineStyle(type: .dotted, color: .orange, width: 10)
                    let borders = PDFTableCellBorders(bottom: style)

                    expect(borders.bottom) == style
                }
            }
        }
    }

}
