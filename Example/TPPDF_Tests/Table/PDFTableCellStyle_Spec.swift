//
//  PDFTableCellStyle_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 16/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFTableCellStyle_Spec: QuickSpec {

    override func spec() {
        describe("PDFTableCellStyle") {

            context("variables") {

                let style = PDFTableCellStyle()

                it("has default colors") {
                    expect(style.colors.fill) == UIColor.clear
                    expect(style.colors.text) == UIColor.black
                }

                it("has default borders") {
                    expect(style.borders) == PDFTableCellBorders()
                }

                it("has a default font") {
                    expect(style.font) == UIFont.systemFont(ofSize: UIFont.systemFontSize)
                }
            }

            context("initalizer") {

                it("can be iniatlized with colors") {
                    let colors = (fill: UIColor.orange, text: UIColor.green)
                    let cell = PDFTableCellStyle(colors: colors)

                    expect(cell.colors.fill) == UIColor.orange
                    expect(cell.colors.text) == UIColor.green
                }

                it("can be iniatlized with borders") {
                    let borders = PDFTableCellBorders(left: PDFLineStyle(type: .dotted, color: .purple, width: 15))
                    let cell = PDFTableCellStyle(borders: borders)

                    expect(cell.borders) == borders
                }

                it("can be iniatlized with a font") {
                    let font = UIFont.systemFont(ofSize: 25)
                    let cell = PDFTableCellStyle(font: font)

                    expect(cell.font) == font
                }
            }
        }
    }

}
