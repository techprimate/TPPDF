//
//  PDFSimpleText_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 14/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFSimpleText_Spec: QuickSpec {

    override func spec() {
        describe("PDFSimpleText") {

            let simpleText = "EXAMPLE"
            let spacing: CGFloat =  10.0
            var textObject: PDFSimpleText!

            beforeEach {
                textObject = PDFSimpleText(text: simpleText, spacing: spacing)
            }

            context("variables") {

                it("has a text instance") {
                    expect(textObject.text) == simpleText
                }

                it("has a spacing instance with default value") {
                    expect(textObject.spacing) == 10.0
                }
            }

            it("can be initalized without spacing") {
                let text = "STRING"

                textObject = PDFSimpleText(text: text)

                expect(textObject.text) == text
                expect(textObject.spacing) == 0
            }

            context("JSONRepresentable") {

                it("can be represented") {
                    expect(textObject.JSONRepresentation).toNot(beNil())
                }
            }
        }
    }

}
