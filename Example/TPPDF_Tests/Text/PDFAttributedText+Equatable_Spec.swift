//
//  PDFAttributedText+Equatable_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 14/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFAttributedText_Equatable_Spec: QuickSpec {

    override func spec() {
        describe("PDFAttributedText") {

            context("Equatable") {

                let text = PDFAttributedText(text: NSAttributedString(string: "EXAMPLE"))

                it("is equal") {
                    let text2 = PDFAttributedText(text: NSAttributedString(string: "EXAMPLE"))
                    expect(text) == text2
                }

                it("is not equal with different text") {
                    let text2 = PDFAttributedText(text: NSAttributedString(string: "INVALID"))
                    expect(text) != text2
                }
            }
        }
    }

}
