//
//  PDFInfo_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 04/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFInfo_Spec: QuickSpec {

    override func spec() {
        describe("PDFInfo") {

            var info: PDFInfo!

            beforeEach {
                info = PDFInfo()
            }

            context("default variables") {

                it("should have default title") {
                    expect(info.title) == "Title"
                }

                it("should have default author") {
                    expect(info.author) == "Author"
                }

                it("should have default subject") {
                    expect(info.subject) == "Subject"
                }

                it("should have default keywords") {
                    expect(info.keywords) == ["tppdf", "pdf", "generator"]
                }

                it("should not have default owner password") {
                    expect(info.ownerPassword).to(beNil())
                }

                it("should not have default user password") {
                    expect(info.userPassword).to(beNil())
                }

                it("should have default allow printing flag") {
                    expect(info.allowsPrinting) == true
                }

                it("should have default allow copying flag") {
                    expect(info.allowsCopying) == true
                }
            }

            it("should generate PDF metadata") {
                info.ownerPassword = "1234"
                info.userPassword = "ABCD"
                info.allowsPrinting = false

                let metadata = info.generate()

                expect(metadata[kCGPDFContextTitle as String] as? String) == "Title"
                expect(metadata[kCGPDFContextAuthor as String] as? String) == "Author"
                expect(metadata[kCGPDFContextSubject as String] as? String) == "Subject"
                expect(metadata[kCGPDFContextKeywords as String] as? [String]) == ["tppdf", "pdf", "generator"]
                expect(metadata[kCGPDFContextAllowsPrinting as String] as? Bool).to(beFalse())
                expect(metadata[kCGPDFContextAllowsCopying as String] as? Bool).to(beTrue())
                expect(metadata[kCGPDFContextOwnerPassword as String] as? String) == "1234"
                expect(metadata[kCGPDFContextUserPassword as String] as? String) == "ABCD"
                expect(metadata[kCGPDFContextCreator as String] as? String) == "TPPDF 0.0.0"
            }
        }
    }

}
