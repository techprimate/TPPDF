//
//  PDFSpaceObject_Spec.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.14.2017.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Nimble
import Quick
@testable import TPPDF

class PDFSpaceObject_Spec: QuickSpec {
    // swiftlint:disable closure_body_length
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

            context("calculation") {
                let document = PDFDocument(format: .a4)
                var generator: PDFGenerator!

                let container = PDFContainer.contentLeft
                var result: [PDFLocatedRenderObject]!

                beforeEach {
                    generator = PDFGenerator(document: document)
                    result = []
                }

                it("can set space") {
                    let contentHeight = generator.layout.heights.content

                    expect {
                        result = try object.calculate(generator: generator, container: container)
                    }.toNot(throwError())
                    expect(generator.layout.heights.content).toEventually(equal(contentHeight + object.frame.height))

                    expect(object.frame) == CGRect(x: 60, y: 60, width: 475, height: space)

                    expect(result).toEventually(haveCount(1))
                    expect(result.first?.0).toEventually(equal(container))
                    expect(result.first?.1 as? PDFSpaceObject).toEventually(be(object))
                }
            }
        }
    }
    // swiftlint:enable closure_body_length
}
