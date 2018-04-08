//
//  PDFInfo+Equatable_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 27.12.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFInfo_Equatable_Spec: QuickSpec {

    override func spec() {
        describe("PDFInfo+Equatable") {

            context("Equatable") {

                var object: PDFInfo!

                beforeEach {
                    object = PDFInfo()
                }

                it("is equal") {
                    let otherObject = PDFInfo()
                    expect(object) == otherObject
                }

                it("is not equal with different title") {
                    let otherObject = PDFInfo()
                    otherObject.title = "OTHER"

                    expect(object) != otherObject
                }

                it("is not equal with different author") {
                    let otherObject = PDFInfo()
                    otherObject.author = "OTHER"

                    expect(object) != otherObject
                }

                it("is not equal with different subject") {
                    let otherObject = PDFInfo()
                    otherObject.subject = "OTHER"

                    expect(object) != otherObject
                }

                it("is not equal with different keywords") {
                    let otherObject = PDFInfo()
                    otherObject.keywords = ["OTHER"]

                    expect(object) != otherObject
                }

                it("is not equal with different owner password") {
                    let otherObject = PDFInfo()
                    otherObject.ownerPassword = "OTHER"

                    expect(object) != otherObject
                }

                it("is not equal with different user password") {
                    let otherObject = PDFInfo()
                    otherObject.userPassword = "OTHER"

                    expect(object) != otherObject
                }

                it("is not equal with different allowsPrinting") {
                    object.allowsPrinting = true

                    let otherObject = PDFInfo()
                    otherObject.allowsPrinting = false

                    expect(object) != otherObject
                }

                it("is not equal with different allows copying") {
                    object.allowsCopying = true

                    let otherObject = PDFInfo()
                    otherObject.allowsCopying = false

                    expect(object) != otherObject
                }
            }
        }
    }

}
