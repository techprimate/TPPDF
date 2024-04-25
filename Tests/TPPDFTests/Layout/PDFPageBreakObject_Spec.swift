//
//  PDFPageBreakObject_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 14/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import CoreGraphics
import Foundation
import Nimble
import Quick
@testable import TPPDF

class PDFPageBreakObject_Spec: QuickSpec {
    override func spec() {
        describe("PDFPageBreakObject") {
            var object: PDFPageBreakObject!

            beforeEach {
                object = PDFPageBreakObject()
            }

            describe("calculation and drawing") {
                let document = PDFDocument(format: .a4)
                var generator: PDFGenerator!
                var context: CGContext!

                let container = PDFContainer.contentLeft
                var result: [PDFLocatedRenderObject]!

                beforeEach {
                    generator = PDFGenerator(document: document)
                    result = []
                    let url = URL(fileURLWithPath: NSTemporaryDirectory())
                        .appendingPathComponent(UUID().uuidString)
                    context = CGContext(url as CFURL, mediaBox: nil, nil)
                }

                it("can set offset") {
                    expect {
                        result = try object.calculate(generator: generator, container: container)
                    }.toNot(throwError())
                    expect(generator.layout.heights.content) == 0

                    expect(result).toEventually(haveCount(1))
                    expect(result.first?.0).toEventually(equal(container))
                    expect(result.first?.1 as? PDFPageBreakObject).toEventually(equal(object))
                }

                it("can be drawn") {
                    expect {
                        try object.draw(generator: generator, container: container, in: PDFContext(cgContext: context))
                    }.toNot(throwError())
                }
            }
        }
    }
}
