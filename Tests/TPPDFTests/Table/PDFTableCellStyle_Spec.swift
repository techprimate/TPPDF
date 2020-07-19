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
                    expect(style.colors.fill) == Color.clear
                    expect(style.colors.text) == Color.black
                }

                it("has default borders") {
                    expect(style.borders) == PDFTableCellBorders()
                }

                it("has a default font") {
                    expect(style.font) == Font.systemFont(ofSize: PDFConstants.defaultFontSize)
                }
            }

            context("initalizer") {

                it("can be iniatlized with colors") {
                    let colors = (fill: Color.orange, text: Color.green)
                    let cell = PDFTableCellStyle(colors: colors)

                    expect(cell.colors.fill) == Color.orange
                    expect(cell.colors.text) == Color.green
                }

                it("can be iniatlized with borders") {
                    let borders = PDFTableCellBorders(left: PDFLineStyle(type: .dotted, color: .purple, width: 15))
                    let cell = PDFTableCellStyle(borders: borders)

                    expect(cell.borders) == borders
                }

                it("can be iniatlized with a font") {
                    let font = Font.systemFont(ofSize: 25)
                    let cell = PDFTableCellStyle(font: font)

                    expect(cell.font) == font
                }
            }
        }
    }

}
