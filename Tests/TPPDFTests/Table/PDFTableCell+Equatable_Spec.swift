//
//  PDFTableCell+Equatable_Spec.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.16.2017.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

import Nimble
import Quick
@testable import TPPDF
import XCTest

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
                    let otherCell = PDFTableCell(content: try XCTUnwrap(PDFTableContent(content: "123")))
                    expect(cell) != otherCell
                }

                it("is not equal with different alignment") {
                    let otherCell = PDFTableCell(alignment: PDFTableCellAlignment.bottomRight)
                    expect(cell) != otherCell
                }

                it("is not equal with different style") {
                    let style = PDFTableCellStyle(colors: (fill: .green, text: .orange))
                    let otherCell = PDFTableCell(style: style)
                    expect(cell) != otherCell
                }
            }
        }
    }
}
