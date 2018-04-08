//
//  PDFAttributedTextObject_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 05/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFAttributedTextObject_Spec: QuickSpec {

    override func spec() {
        describe("PDFAttributedTextObject") {

            describe("initializer") {

                let simpleText = "example"

                it("can be initialized with a simple object") {
                    let simpleTextObject = PDFSimpleText(text: simpleText)

                    let textObject = PDFAttributedTextObject(text: simpleTextObject)
                    expect(textObject.simpleText).toNot(beNil())
                    expect(textObject.attributedText).to(beNil())
                }

                it("can be initialized with a simple object") {
                    let attributedText = NSAttributedString(string: simpleText)
                    let attributedTextObject = PDFAttributedText(text: attributedText)

                    let textObject = PDFAttributedTextObject(text: attributedTextObject)
                    expect(textObject.simpleText).to(beNil())
                    expect(textObject.attributedText).toNot(beNil())
                }

                it("can not be initialized with a custom object") {
                    #if arch(x86_64)
                        class CustomTextObject: PDFText {}

                        let custom = CustomTextObject()
                        expect {
                            let _ = PDFAttributedTextObject(text: custom)
                            return nil
                            }.to(throwAssertion())
                    #endif
                }
            }
        }
    }

}
