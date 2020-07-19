//
//  PDFTableContent_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 16/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import TPPDF

class PDFTableContent_Spec: QuickSpec {

    override func spec() {
        describe("PDFTableContent") {

            context("enum ContentType") {

                it("has a value none") {
                    expect(PDFTableContent.ContentType.none).toNot(beNil())
                }

                it("has a value none") {
                    expect(PDFTableContent.ContentType.string).toNot(beNil())
                }

                it("has a value none") {
                    expect(PDFTableContent.ContentType.attributedString).toNot(beNil())
                }

                it("has a value none") {
                    expect(PDFTableContent.ContentType.image).toNot(beNil())
                }
            }

            context("variables") {

                it("has a default type") {
                    expect((try? PDFTableContent(content: nil))?.type) == PDFTableContent.ContentType.none
                }

                it("has an optional content") {
                    let content = try? PDFTableContent(content: nil)
                    expect(content).toNot(beNil())
                    expect(content?.content).to(beNil())
                }
            }

            context("initializer") {

                it("can be initalized with any") {
                    expect {
                        try PDFTableContent(content: 123)
                        }.toNot(throwError())
                    expect {
                        try PDFTableContent(content: ["EXAMPLE"])
                        }.to(throwError())
                }

                it("can be initalized with type and optional content") {
                    let content = PDFTableContent(type: PDFTableContent.ContentType.attributedString,
                                                  content: NSAttributedString(string: "EXAMPLE"))
                    expect(content.type) == PDFTableContent.ContentType.attributedString
                    expect(content.content as? NSAttributedString) == NSAttributedString(string: "EXAMPLE")
                }
            }

            context("content") {

                var content: PDFTableContent!

                beforeEach {
                    content = try! PDFTableContent(content: nil)
                }

                it("can set to nil") {
                    expect {
                        try content.setContent(content: nil)
                        }.toNot(throwError())
                    expect(content.type).toEventually(equal(PDFTableContent.ContentType.none))
                    expect(content.content).toEventually(beNil())
                }

                it("can set to string") {
                    let content = try! PDFTableContent(content: nil)

                    expect {
                        try content.setContent(content: "EXAMPLE")
                        }.toNot(throwError())
                    expect(content.type).toEventually(equal(PDFTableContent.ContentType.string))
                    expect(content.content as? String).toEventually(equal("EXAMPLE"))
                }

                it("can set to image") {
                    let value = Image()

                    expect {
                        try content.setContent(content: value)
                        }.toNot(throwError())
                    expect(content.type).toEventually(equal(PDFTableContent.ContentType.image))
                    expect(content.content as? Image).toEventually(equal(value))
                }

                it("can set to attributed string") {
                    let value = NSAttributedString(string: "EXAMPLE")

                    expect {
                        try content.setContent(content: value)
                        }.toNot(throwError())
                    expect(content.type).toEventually(equal(PDFTableContent.ContentType.attributedString))
                    expect(content.content as? NSAttributedString).toEventually(equal(value))
                }

                it("can set to int") {
                    let value = 123456

                    expect {
                        try content.setContent(content: value)
                        }.toNot(throwError())
                    expect(content.type).toEventually(equal(PDFTableContent.ContentType.string))
                    expect(content.content as? String).toEventually(equal("123456"))
                }

                it("can set to double") {
                    let value = Double(123.456)

                    expect {
                        try content.setContent(content: value)
                        }.toNot(throwError())
                    expect(content.type).toEventually(equal(PDFTableContent.ContentType.string))
                    expect(content.content as? String).toEventually(equal("123.456"))
                }

                it("can set to float") {
                    let value = Float(123.456)

                    expect {
                        try content.setContent(content: value)
                        }.toNot(throwError())
                    expect(content.type).toEventually(equal(PDFTableContent.ContentType.string))
                    expect(content.content as? String).toEventually(equal("123.456"))
                }

                it("can not set to unsupported") {
                    let value = ["INVALID"]

                    expect {
                        try content.setContent(content: value)
                        }.to(throwError())
                }
            }

            context("computed variables") {

                var content: PDFTableContent!

                beforeEach {
                    content = PDFTableContent(type: .none, content: nil)
                }

                it("is a string") {
                    content.type = .string
                    expect(content.isString).to(beTrue())

                    content.type = .none
                    expect(content.isString).to(beFalse())

                    content.type = .image
                    expect(content.isString).to(beFalse())

                    content.type = .attributedString
                    expect(content.isString).to(beFalse())
                }

                it("is an attributed string") {
                    content.type = .attributedString
                    expect(content.isAttributedString).to(beTrue())

                    content.type = .none
                    expect(content.isAttributedString).to(beFalse())

                    content.type = .image
                    expect(content.isAttributedString).to(beFalse())

                    content.type = .string
                    expect(content.isAttributedString).to(beFalse())
                }

                it("is an image") {
                    content.type = .image
                    expect(content.isImage).to(beTrue())

                    content.type = .none
                    expect(content.isImage).to(beFalse())

                    content.type = .attributedString
                    expect(content.isImage).to(beFalse())

                    content.type = .string
                    expect(content.isImage).to(beFalse())
                }

                it("can get string value") {
                    content.content = "EXAMPLE"
                    content.type = .string
                    expect(content.stringValue) == "EXAMPLE"

                    content.type = .none
                    expect(content.stringValue).to(beNil())

                    content.type = .attributedString
                    expect(content.stringValue).to(beNil())

                    content.type = .image
                    expect(content.stringValue).to(beNil())
                }

                it("can get attributed string value") {
                    content.content = NSAttributedString(string: "EXAMPLE")
                    content.type = .attributedString
                    expect(content.attributedStringValue) == NSAttributedString(string: "EXAMPLE")

                    content.type = .none
                    expect(content.attributedStringValue).to(beNil())

                    content.type = .string
                    expect(content.attributedStringValue).to(beNil())

                    content.type = .image
                    expect(content.attributedStringValue).to(beNil())
                }

                it("can get image value") {
                    content.content = Image()
                    content.type = .image
                    expect(content.imageValue) == content.content as? Image

                    content.type = .none
                    expect(content.imageValue).to(beNil())

                    content.type = .string
                    expect(content.imageValue).to(beNil())

                    content.type = .attributedString
                    expect(content.imageValue).to(beNil())
                }
            }

            context("extensions") {

                context("String") {

                    it("can be converted to content") {
                        let value = "EXAMPLE"
                        let content = value.asTableContent
                        expect(content.content as? String) == value
                        expect(content.type) == PDFTableContent.ContentType.string
                    }
                }

                context("NSAttributedString") {

                    it("can be converted to content") {
                        let attributedString = NSAttributedString(string: "EXAMPLE")
                        let content = attributedString.asTableContent
                        expect(content.content as? NSAttributedString) == attributedString
                        expect(content.type) == PDFTableContent.ContentType.attributedString
                    }
                }

                context("Image") {

                    it("can be converted to content") {
                        let image = Image()
                        let content = image.asTableContent
                        expect(content.content as? Image).to(be(image))
                        expect(content.type) == PDFTableContent.ContentType.image
                    }
                }
            }
        }
    }

}
