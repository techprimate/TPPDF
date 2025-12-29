//
//  PDFSimpleText+Equatable_Spec.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.14.2017.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

import Nimble
import Quick
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
