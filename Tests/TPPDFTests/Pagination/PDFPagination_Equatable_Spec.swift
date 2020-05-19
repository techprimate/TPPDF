//
//  PDFPagination_Equatable_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 04/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFPagination_Equatable_Spec: QuickSpec {

    override func spec() {
        describe("PDFPagination") {

            context("Equatable") {

                it("can be equated") {
                    let pagination = PDFPagination()

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

}
