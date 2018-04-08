//
//  PDFSimpleText+Equatable_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 14/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFSimpleText_Equatable_Spec: QuickSpec {

    override func spec() {
        describe("PDFSimpleText") {

            context("Equatable") {

                let text = PDFSimpleText(text: "EXAMPLE")

                it("is equal") {
                    let otherText = PDFSimpleText(text: "EXAMPLE")
                    expect(text) == otherText
                }

                it("is not equal with different text") {
                    let otherText = PDFSimpleText(text: "DIFFERENT")
                    expect(text) != otherText
                }

                it("is not equal with different spacing") {
                    let otherText = PDFSimpleText(text: "EXAMPLE", spacing: 20)
                    expect(text) != otherText
                }
            }
        }
    }

}
