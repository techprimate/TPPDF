//
//  PDFIndentationObject_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 14/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFIndentationObject_Spec: QuickSpec {

    override func spec() {
        describe("PDFIndentationObject") {

            var object: PDFIndentationObject!
            let indentation: CGFloat = 20.0
            let left = false

            beforeEach {
                object = PDFIndentationObject(indentation: indentation, left: left)
            }

            describe("variables") {

                it("has an indentation") {
                    expect(object.indentation) == indentation
                }

                it("has a left") {
                    expect(object.left) == left
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

                it("can set indentation from left") {
                    object.left = true

                    expect {
                        result = try object.calculate(generator: generator, container: container)
                        }.toNot(throwError())
                    expect(generator.layout.indentation.leftIn(container: PDFContainer.contentLeft)).toEventually(equal(object.indentation))

                    expect(result).toEventually(haveCount(1))
                    expect(result.first?.0).toEventually(equal(container))
                    expect(result.first?.1 as? PDFIndentationObject).toEventually(equal(object))
                }

                it("can set indentation from right") {
                    object.left = false
                    expect {
                        result = try object.calculate(generator: generator, container: PDFContainer.contentLeft)
                        }.toNot(throwError())
                    expect(generator.layout.indentation.rightIn(container: PDFContainer.contentLeft)).toEventually(equal(object.indentation))


                    expect(result).toEventually(haveCount(1))
                    expect(result.first?.0).toEventually(equal(container))
                    expect(result.first?.1 as? PDFIndentationObject).toEventually(equal(object))
                }
            }
        }
    }

}
