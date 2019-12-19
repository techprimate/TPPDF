//
//  PDFOffsetObject_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 14/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFOffsetObject_Spec: QuickSpec {

    override func spec() {
        describe("PDFOffsetObject") {

            var object: PDFOffsetObject!
            let offset: CGFloat = 20.0

            beforeEach {
                object = PDFOffsetObject(offset: offset)
            }

            describe("variables") {

                it("has an offset value") {
                    expect(object.offset) == offset
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

                it("can set offset") {
                    expect {
                        result = try object.calculate(generator: generator, container: container)
                        }.toNot(throwError())
                    expect(generator.layout.getContentOffset(in: container)).toEventually(equal(object.offset))

                    expect(result).toEventually(haveCount(1))
                    expect(result.first?.0).toEventually(equal(container))
                    expect(result.first?.1 as? PDFOffsetObject).toEventually(equal(object))
                }
            }
        }
    }

}
