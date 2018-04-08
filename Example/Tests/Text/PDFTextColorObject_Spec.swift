//
//  PDFTextColorObject_Spec.swift
//  TPPDF_Example
//
//  Created by Philip Niedertscheider on 05.12.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFTextColorObject_Spec: QuickSpec {

    override func spec() {
        describe("PDFTextColorObject") {

            let color = UIColor.red
            var object: PDFTextColorObject!

            beforeEach {
                object = PDFTextColorObject(color: color)
            }

            context("variables") {

                it("has a color instance") {
                    expect(object.color) == color
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
                    expect(generator.textColor[container]).toEventually(equal(color))

                    expect(object.frame) == CGRect.zero

                    expect(result).toEventually(haveCount(1))
                    expect(result.first?.0).toEventually(equal(container))
                    expect(result.first?.1 as? PDFTextColorObject).toEventually(be(object))
                }
            }
        }
    }

}
