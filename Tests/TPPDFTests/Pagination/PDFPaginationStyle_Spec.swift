//
//  PDFPaginationStyle_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 04/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
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
            }

            context("roman") {

                let style = PDFPaginationStyle.roman(template: "%@ / %@")

                it("can format a page number") {
                    expect(style.format(page: 2, total: 7)) == "II / VII"
                }
            }

            context("customNumberFormat") {

                let formatter = NumberFormatter()
                formatter.minimumFractionDigits = 2

                let style = PDFPaginationStyle.customNumberFormat(template: "%@ +++ %@", formatter: formatter)

                it("can format a page number") {
                    let ds = Locale.current.decimalSeparator!
                    expect(style.format(page: 2, total: 7)) == "2\(ds)00 +++ 7\(ds)00"
                }
            }

            context("customClosure") {

                let style = PDFPaginationStyle.customClosure { (page, total) -> String in
                    return String(format: "%i - %i", page * page, 2 * total)
                }

                it("can format a page number") {
                    expect(style.format(page: 3, total: 7)) == "9 - 14"
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
