//
//  PDFPagination_Spec.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.04.2017.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

import Nimble
import Quick
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
        }
    }
}
