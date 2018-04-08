//
//  PDFObject_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 02/11/2017.
//

import Quick
import Nimble
@testable import TPPDF

class PDFObject_Spec: QuickSpec {

    override func spec() {

        describe("PDFObject") {

            let object = PDFObject()

            it("should have a zero frame as default") {
                expect(object.frame) == CGRect.zero
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
                    var objects: [(PDFContainer, PDFObject)]?
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
