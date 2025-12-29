//
//  PDFIndentationObject_Spec.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.14.2017.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Nimble
import Quick
@testable import TPPDF

class PDFIndentationObject_Spec: QuickSpec {
    // swiftlint:disable closure_body_length
    override func spec() {
        describe("PDFIndentationObject") {
            var object: PDFIndentationObject!
            let indentation: CGFloat = 20.0
            let left = false
            let insideSectionColumn = false

            beforeEach {
                object = PDFIndentationObject(indentation: indentation, left: left, insideSectionColumn: insideSectionColumn)
            }

            describe("variables") {
                it("has an indentation") {
                    expect(object.indentation) == indentation
                }

                it("has a left") {
                    expect(object.left) == left
                }

                it("has a insideSectionColumn") {
                    expect(object.insideSectionColumn) == insideSectionColumn
                }
            }

            describe("calculation") {
                let document = PDFDocument(format: .a4)
                var generator: PDFGenerator!

                let container = PDFContainer.contentLeft
                var result: [PDFLocatedRenderObject]!

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
    // swiftlint:enable closure_body_length
}
