//
//  PDFSimpleText_Spec.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.14.2017.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Nimble
import Quick
@testable import TPPDF

class PDFSimpleText_Spec: QuickSpec {
    override func spec() {
        describe("PDFSimpleText") {
            let simpleText = "EXAMPLE"
            let spacing: CGFloat = 10.0
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

            it("can be initialized without spacing") {
                let text = "STRING"

                textObject = PDFSimpleText(text: text)

                expect(textObject.text) == text
                expect(textObject.spacing) == 0
            }
        }
    }
}
