//
//  PDFPaginationStyle+Equatable_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 27.12.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFPaginationStyle_Equatable_Spec: QuickSpec {

    override func spec() {
        describe("PDFPaginationStyle") {

            context("Equatable") {

                it("is equal when both default") {
                    let lhsPagination = PDFPaginationStyle.default
                    let rhsPagination = PDFPaginationStyle.default

                    expect(lhsPagination) == rhsPagination
                }

                it("is not equal with different roman template") {
                    let firstPagination = PDFPaginationStyle.roman(template: "123")
                    let secondPagination = PDFPaginationStyle.roman(template: "123")
                    let thirdPagination = PDFPaginationStyle.roman(template: "456")

                    expect(firstPagination) == firstPagination
                    expect(firstPagination) == secondPagination
                    expect(firstPagination) != thirdPagination
                    expect(secondPagination) != thirdPagination
                }

                it("is not equal with different custom number formatter") {
                    let firstFormatter = NumberFormatter()
                    firstFormatter.numberStyle = NumberFormatter.Style.percent

                    let secondFormatter = NumberFormatter()
                    secondFormatter.numberStyle = NumberFormatter.Style.decimal


                    let firstTemplate = "123"
                    let secondTemplate = "456"

                    let paginations = [
                        PDFPaginationStyle.customNumberFormat(template: firstTemplate, formatter: firstFormatter),
                        PDFPaginationStyle.customNumberFormat(template: firstTemplate, formatter: secondFormatter),

                        PDFPaginationStyle.customNumberFormat(template: secondTemplate, formatter: firstFormatter),
                        PDFPaginationStyle.customNumberFormat(template: secondTemplate, formatter: secondFormatter)
                    ]

                    expect(paginations[0]) == paginations[0]
                    expect(paginations[0]) != paginations[1]
                    expect(paginations[0]) != paginations[2]
                    expect(paginations[0]) != paginations[3]

                    expect(paginations[1]) != paginations[0]
                    expect(paginations[1]) == paginations[1]
                    expect(paginations[1]) != paginations[2]
                    expect(paginations[1]) != paginations[3]

                    expect(paginations[2]) != paginations[0]
                    expect(paginations[2]) != paginations[1]
                    expect(paginations[2]) == paginations[2]
                    expect(paginations[2]) != paginations[3]

                    expect(paginations[3]) != paginations[0]
                    expect(paginations[3]) != paginations[1]
                    expect(paginations[3]) != paginations[2]
                    expect(paginations[3]) == paginations[3]
                }

                it("is never equal with custom closure") {
                    let pagination = PDFPaginationStyle.customClosure { (page, total) -> String in
                        return ""
                    }
                    expect(pagination) != pagination
                    expect(pagination.format(page: 1, total: 2)) == ""
                }
            }
        }
    }

}
