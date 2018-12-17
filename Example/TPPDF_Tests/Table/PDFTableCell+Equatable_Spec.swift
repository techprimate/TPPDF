//
//  PDFTableCell+Equatable_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 16/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFTableCell_Equatable_Spec: QuickSpec {

    override func spec() {
        describe("PDFTableCell") {

            context("Equatable") {

                let cell = PDFTableCell()

                it("is equal") {
                    let otherCell = PDFTableCell()
                    expect(cell) == otherCell
                }

                it("is not equal with different content") {
                    let otherCell = PDFTableCell(content: try! PDFTableContent(content: "123"))
                    expect(cell) != otherCell
                }

                it("is not equal with different alignment") {
                    let otherCell = PDFTableCell(alignment: PDFTableCellAlignment.bottomRight)
                    expect(cell) != otherCell
                }

                it("is not equal with different style") {
                    let style = PDFTableCellStyle(colors: (fill: UIColor.green, text: UIColor.orange))
                    let otherCell = PDFTableCell(style: style)
                    expect(cell) != otherCell
                }
            }
        }
    }

}
