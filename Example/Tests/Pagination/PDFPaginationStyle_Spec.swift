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

                let style = PDFPaginationStyle.customClosure { (page, total) -> String in
                    return String(format: "%i - %i", page * page, 2 * total)
                }

                it("can format a page number") {
                    expect(style.format(page: 3, total: 7)) == "9 - 14"
                }

                it("can create a JSON representable") {
                    expect(style.JSONRepresentation as? String).toNot(beNil())
                    expect(style.JSONRepresentation as? String) == "PDFPaginationStyle.customClosure"
                }
            }

            context("equatable") {

                it("can be equated when default") {
                    expect(PDFPaginationStyle.default == PDFPaginationStyle.default).to(beTrue())
                }

                it("can be equated when default") {
                    expect(PDFPaginationStyle.roman(template: "%@ - %@") == PDFPaginationStyle.roman(template: "%@ - %@")).to(beTrue())
                    expect(PDFPaginationStyle.roman(template: "%@ - %@") == PDFPaginationStyle.roman(template: "%@ / %@")).to(beFalse())
                }

                it("can be equated when default") {
                    let numberFormatter1 = NumberFormatter()
                    let numberFormatter2 = NumberFormatter()
                    let template1 = "%@ - %@"
                    let template2 = "%@ / %@"

                    expect(
                        PDFPaginationStyle.customNumberFormat(template: template1, formatter: numberFormatter1) ==
                            PDFPaginationStyle.customNumberFormat(template: template1, formatter: numberFormatter1)
                        ).to(beTrue())
                    expect(
                        PDFPaginationStyle.customNumberFormat(template: template1, formatter: numberFormatter1) ==
                            PDFPaginationStyle.customNumberFormat(template: template1, formatter: numberFormatter2)
                        ).to(beFalse())
                    expect(
                        PDFPaginationStyle.customNumberFormat(template: template1, formatter: numberFormatter1) ==
                            PDFPaginationStyle.customNumberFormat(template: template2, formatter: numberFormatter1)
                        ).to(beFalse())
                    expect(
                        PDFPaginationStyle.customNumberFormat(template: template1, formatter: numberFormatter1) ==
                            PDFPaginationStyle.customNumberFormat(template: template2, formatter: numberFormatter2)
                        ).to(beFalse())
                }

                it("can be equated when default") {
                    expect(PDFPaginationStyle.customClosure { (page, total) -> String in
                        return String(format: "%@ %@", page, total)
                    } == PDFPaginationStyle.customClosure { (page, total) -> String in
                        return String(format: "%@ %@", page, total)
                    }).to(beFalse())
                }
            }
        }
    }

}
