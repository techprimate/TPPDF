//
//  PDFTableCell_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 16/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFTableCell_Spec: QuickSpec {

    override func spec() {
        describe("PDFTableCell") {

            context("variables") {

                let cell = PDFTableCell()

                it("has an optional content") {
                    expect(cell.content).to(beNil())
                }

                it("has an optional style") {
                    expect(cell.style).to(beNil())
                }

                it("has a default alignment") {
                    expect(cell.alignment) == PDFTableCellAlignment.center
                }
            }

            context("initalizer") {

                it("can be iniatlized with a content") {
                    let content = try! PDFTableContent(content: "EXAMPLE")
                    let cell = PDFTableCell(content: content)

                    expect(cell.content) == content
                }

                it("can be iniatlized with an alignment") {
                    let alignment = PDFTableCellAlignment.bottomRight
                    let cell = PDFTableCell(alignment: alignment)

                    expect(cell.alignment) == alignment
                }

                it("can be iniatlized with a style") {
                    let style = PDFTableCellStyle(colors: (fill: UIColor.blue, text: UIColor.green))
                    let cell = PDFTableCell(style: style)

                    expect(cell.style) == style
                }
            }
        }
    }

}
