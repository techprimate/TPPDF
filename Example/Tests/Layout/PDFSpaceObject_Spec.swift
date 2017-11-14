//
//  PDFSpaceObject_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 14/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFSpaceObject_Spec: QuickSpec {

    override func spec() {
        describe("PDFSpaceObject") {

            var object: PDFSpaceObject!
            let space: CGFloat = 20.0

            beforeEach {
                object = PDFSpaceObject(space: space)
            }

            describe("variables") {

                it("has an space value") {
                    expect(object.space) == space
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

                it("can set space") {
                    let x = document.layout.margin.left
                        + generator.layout.indentation.leftIn(container: container)

                    let y = document.layout.margin.bottom
                        + generator.layout.heights.maxHeaderHeight()
                        + document.layout.space.header
                        + generator.layout.heights.content

                    let width = document.layout.size.width
                        - document.layout.margin.left
                        - generator.layout.indentation.leftIn(container: container)
                        - generator.layout.indentation.rightIn(container: container)
                        - document.layout.margin.right

                    let contentHeight = generator.layout.heights.content

                    expect {
                        result = try object.calculate(generator: generator, container: container)
                        }.toNot(throwError())
                    expect(generator.layout.heights.content).toEventually(equal(contentHeight + object.frame.height))

                    expect(object.frame) == CGRect(x: x, y: y, width: width, height: space)

                    expect(result).toEventually(haveCount(1))
                    expect(result.first?.0).toEventually(equal(container))
                    expect(result.first?.1 as? PDFSpaceObject).toEventually(be(object))
                }
            }
        }
    }
}

