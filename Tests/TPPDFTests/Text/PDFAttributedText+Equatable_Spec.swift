//
//  PDFAttributedText+Equatable_Spec.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.14.2017.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

import Foundation
import Nimble
import Quick
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
