//
//  PDFPagination_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 04/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFPagination_Spec: QuickSpec {

    override func spec() {
        describe("PDFPagination") {

            var pagination: PDFPagination!

            beforeEach {
                pagination = PDFPagination()
            }

            context("default variables") {

                it("should have a default container") {
                    expect(pagination.container) == PDFContainer.none
                }

                it("should have a default style") {
                    expect(pagination.style) == PDFPaginationStyle.default
                }

                it("should have a default range") {
                    expect(pagination.range.start) == 0
                    expect(pagination.range.end) == Int.max
                }

                it("should not have any default hidden pages") {
                    expect(pagination.hiddenPages) == []
                }
            }

            it("can be equated") {
                var pagination1 = PDFPagination()
                pagination1.container = PDFContainer.contentLeft

                var pagination2 = PDFPagination()
                pagination2.style = PDFPaginationStyle.roman(template: "%@ / %@")

                var pagination3 = PDFPagination()
                pagination3.range = (start: 2, end: 5)

                var pagination4 = PDFPagination()
                pagination4.hiddenPages = [1, 2, 3]

                expect(pagination1) != pagination
                expect(pagination2) != pagination
                expect(pagination3) != pagination
                expect(pagination4) != pagination
            }
        }
    }
}
