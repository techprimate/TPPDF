//
//  PDFTableCellStyle+Equatable_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 16/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFTableCellStyle_Equatable_Spec: QuickSpec {

    override func spec() {
        describe("PDFTableCellStyle") {

            context("Equatable") {

                let style = PDFTableCellStyle()

                it("is equal") {
                    let otherStyle = PDFTableCellStyle()
                    expect(style) == otherStyle
                }

                it("is not equal with different colors") {
                    let colors = (fill: UIColor.red, text: UIColor.blue)
                    let otherStyle = PDFTableCellStyle(colors: colors)
                    expect(style) != otherStyle
                }

                it("is not equal with different borders") {
                    let borders = PDFTableCellBorders(left: PDFLineStyle(type: .dotted))
                    let otherStyle = PDFTableCellStyle(borders: borders)
                    expect(style) != otherStyle
                }

                it("is not equal with different font") {
                    let font = UIFont.boldSystemFont(ofSize: 10.0)
                    let otherStyle = PDFTableCellStyle(font: font)
                    expect(style) != otherStyle
                }
            }
        }
    }

}
