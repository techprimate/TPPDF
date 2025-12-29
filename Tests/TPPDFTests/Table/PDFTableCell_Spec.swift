//
//  PDFTableCell_Spec.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.16.2017.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

import Nimble
import Quick
@testable import TPPDF
import XCTest

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

            context("initializer") {
                it("can be initialized with a content") {
                    let content = try XCTUnwrap(PDFTableContent(content: "EXAMPLE"))
                    let cell = PDFTableCell(content: content)

                    expect(cell.content) == content
                }

                it("can be initialized with an alignment") {
                    let alignment = PDFTableCellAlignment.bottomRight
                    let cell = PDFTableCell(alignment: alignment)

                    expect(cell.alignment) == alignment
                }

                it("can be initialized with a style") {
                    let style = PDFTableCellStyle(colors: (fill: Color.blue, text: Color.green))
                    let cell = PDFTableCell(style: style)

                    expect(cell.style) == style
                }
            }
        }
    }
}
