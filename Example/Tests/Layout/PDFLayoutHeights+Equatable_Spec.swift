//
//  PDFLayoutHeights+Equatable_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 14/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFLayoutHeights_Equatable_Spec: QuickSpec {

    override func spec() {
        describe("PDFLayoutHeights") {

            context("Equatable") {

                let heights = PDFLayoutHeights()

                it("is equal") {
                    let otherHeights = PDFLayoutHeights()
                    expect(heights) == otherHeights
                }

                it("is not equal with different header") {
                    var otherHeights = PDFLayoutHeights()
                    otherHeights.header = [PDFContainer.headerLeft: 10]
                    expect(heights) != otherHeights
                }

                it("is not equal with different footer") {
                    var otherHeights = PDFLayoutHeights()
                    otherHeights.footer = [PDFContainer.footerLeft: 10]
                    expect(heights) != otherHeights
                }

                it("is not equal with different content value") {
                    var otherHeights = PDFLayoutHeights()
                    otherHeights.content = 123
                    expect(heights) != otherHeights
                }
            }
        }
    }

}
