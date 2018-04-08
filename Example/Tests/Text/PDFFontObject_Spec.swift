//
//  PDFFontObject_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 06.12.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFFontObject_Spec: QuickSpec {

    override func spec() {
        describe("PDFFontObject") {

            let font = UIFont.boldSystemFont(ofSize: 100)
            var object: PDFFontObject!

            beforeEach {
                object = PDFFontObject(font: font)
            }

            context("variables") {

                it("has a font instance") {
                    expect(object.font) == font
                }
            }

            describe("calculation") {

                let document = PDFDocument(format: .a4)
                var generator: PDFGenerator!

                let container = PDFContainer.contentLeft
                var result: [(PDFContainer, PDFObject)]!

                beforeEach {
                    generator = PDFGenerator(document: document)
                    result = []
                }

                it("can set text color") {
                    expect {
                        result = try object.calculate(generator: generator, container: container)
                        }.toNot(throwError())
                    expect(generator.fonts[container]).toEventually(equal(font))

                    expect(object.frame) == CGRect.zero

                    expect(result).toEventually(haveCount(1))
                    expect(result.first?.0).toEventually(equal(container))
                    expect(result.first?.1 as? PDFFontObject).toEventually(be(object))
                }
            }
        }
    }

}
