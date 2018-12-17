//
//  PDFTableContent+Equatable_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 16/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFTableContent_Equatable_Spec: QuickSpec {

    override func spec() {
        describe("PDFTableContent") {

            context("Equatable") {

                var content: PDFTableContent!

                beforeEach {
                    content = PDFTableContent(type: .none, content: nil)
                }

                it("is equal") {
                    let otherContent = PDFTableContent(type: .none, content: nil)
                    expect(content) == otherContent
                }

                it("is not equal with different type") {
                    let otherContent = PDFTableContent(type: .string, content: nil)
                    expect(content) != otherContent
                }

                it("is not equal with different strings") {
                    content.type = .string
                    content.content = "EXAMPLE"
                    let otherContent = PDFTableContent(type: .string, content: "INVALID")
                    expect(content) != otherContent
                }

                it("is not equal with different attributed strings") {
                    content.type = .attributedString
                    content.content = NSAttributedString(string: "EXAMPLE")

                    let otherContent = PDFTableContent(type: .attributedString, content: NSAttributedString(string: "INVALID"))
                    expect(content) != otherContent
                }

                it("is not equal with different images") {
                    content.type = .image
                    content.content = UIImage()

                    let otherContent = PDFTableContent(type: .image, content: UIImage())
                    expect(content) != otherContent
                }

                it("is not equal with different content nil") {
                    content.type = .image
                    content.content = UIImage()

                    var otherContent = PDFTableContent(type: .image, content: nil)
                    expect(content) != otherContent

                    content.type = .image
                    content.content = nil

                    otherContent = PDFTableContent(type: .image, content: UIImage())
                    expect(content) != otherContent
                }

                it("ignores content if unknown objects") {
                    content.type = .image
                    content.content = ["RANDOM"]

                    let otherContent = PDFTableContent(type: .image, content: ["RANDOM"])
                    expect(content) == otherContent
                }
            }
        }
    }

}
