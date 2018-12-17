//
//  PDFAttributedText_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 05/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFAttributedText_Spec: QuickSpec {

    override func spec() {
        describe("PDFAttributedText") {

            it("can be initalized with an attributed string") {
                let attributed = NSAttributedString(string: "example")
                let textObject = PDFAttributedText(text: attributed)

                expect(textObject.text) == attributed
            }
        }
    }

}
