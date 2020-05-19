//
//  PDFObject_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 02/11/2017.
//

import UIKit
import Quick
import Nimble
@testable import TPPDF

class PDFObject_Spec: QuickSpec {

    override func spec() {

        describe("PDFObject") {

            let object = PDFRenderObject()

            it("should have a null frame as default") {
                expect(object.frame) == CGRect.null
            }

            context("generator") {
                var document: PDFDocument!
                var generator: PDFGenerator!
                var container: PDFContainer!

                beforeEach {
                    document = PDFDocument(format: .a4)
                    generator = PDFGenerator(document: document)
                    container = PDFContainer.none
                }

                it("should return a empty subobjects array when calculating") {
                    var objects: [PDFLocatedRenderObject]?
                    expect {
                        objects = try object.calculate(generator: generator, container: container)
                    }.toNot(throwError())

                    expect(objects).toEventually(beEmpty())
                }

                it("should have a draw method") {
                    expect {
                        try object.draw(generator: generator, container: container)
                    }.toNot(throwError())
                }
            }
        }
    }

}
