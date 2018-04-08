//
//  PDFText_Spec.swift
//  TPPDF_Example
//
//  Created by Philip Niedertscheider on 05.12.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFText_Spec: QuickSpec {

    override func spec() {
        describe("PDFSimpleText") {

            context("Equatable") {

                it("is equal if both simple text") {
                    let text: PDFText = PDFSimpleText(text: "EXAMPLE")
                    let otherText: PDFText = PDFSimpleText(text: "EXAMPLE")

                    expect(text == otherText).to(beTrue())
                    expect(text != otherText).to(beFalse())
                }

                it("is equal if both attributed text") {
                    let text: PDFText = PDFAttributedText(text: NSAttributedString(string: "EXAMPLE"))
                    let otherText: PDFText = PDFAttributedText(text: NSAttributedString(string: "EXAMPLE"))

                    expect(text == otherText).to(beTrue())
                    expect(text != otherText).to(beFalse())
                }

                it("is not equal with different text subclasses") {
                    let text: PDFText = PDFSimpleText(text: "EXAMPLE")
                    let otherText: PDFText = PDFAttributedText(text: NSAttributedString(string: "EXAMPLE"))

                    expect(text == otherText).to(beFalse())
                }
            }
        }
    }

}
