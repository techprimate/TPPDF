//
//  PDFAttributedText_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 05/11/2017.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

import Foundation
import Nimble
import Quick
@testable import TPPDF

class PDFAttributedText_Spec: QuickSpec {
    override func spec() {
        describe("PDFAttributedText") {
            it("can be initialized with an attributed string") {
                let attributed = NSAttributedString(string: "example")
                let textObject = PDFAttributedText(text: attributed)

                expect(textObject.text) == attributed
            }
        }
    }
}
