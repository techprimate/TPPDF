//
//  PDFPaginationStyle_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 04/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFPaginationStyle_Spec: QuickSpec {

    override func spec() {
        describe("PDFPagiationStyle") {

            context("default") {

                let style = PDFPaginationStyle.default

                it("can format a page number") {
                    expect(style.format(page: 2, total: 7)) == "2 - 7"
                }

                it("can create a JSON representable") {
                    expect(style.JSONRepresentation as? String).toNot(beNil())
                    expect(style.JSONRepresentation as? String) == "PDFPaginationStyle.default"
                }
            }

            context("roman") {

                let style = PDFPaginationStyle.roman(template: "%@ / %@")

                it("can format a page number") {
                    expect(style.format(page: 2, total: 7)) == "II / VII"
                }

                it("can create a JSON representable") {
                    expect(style.JSONRepresentation as? String).toNot(beNil())
                    expect(style.JSONRepresentation as? String) == "PDFPaginationStyle.roman(%@ / %@)"
                }
            }

            context("customNumberFormat") {

                let formatter = NumberFormatter()
                formatter.minimumFractionDigits = 2

                let style = PDFPaginationStyle.customNumberFormat(template: "%@ +++ %@", formatter: formatter)

                it("can format a page number") {
                    expect(style.format(page: 2, total: 7)) == "2.00 +++ 7.00"
                }

                it("can create a JSON representable") {
                    expect(style.JSONRepresentation as? String).toNot(beNil())
                    expect(style.JSONRepresentation as? String) == "PDFPaginationStyle.customNumberFormat(%@ +++ %@)"
                }
            }

            context("customClosure") {

                let style = PDFPaginationStyle.customClosure({ (page, total) -> String in
                    return String(format: "%i - %i", page * page, 2 * total)
                })

                it("can format a page number") {
                    expect(style.format(page: 3, total: 7)) == "9 - 14"
                }

                it("can create a JSON representable") {
                    expect(style.JSONRepresentation as? String).toNot(beNil())
                    expect(style.JSONRepresentation as? String) == "PDFPaginationStyle.customClosure"
                }
            }
        }
    }
}
