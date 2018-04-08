//
//  PDFContainer_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 09/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFContainer_Spec: QuickSpec {

    override func spec() {
        describe("PDFContainer") {

            it("should have enum values") {
                expect(PDFContainer.none).toNot(beNil())

                expect(PDFContainer.headerLeft).toNot(beNil())
                expect(PDFContainer.headerCenter).toNot(beNil())
                expect(PDFContainer.headerRight).toNot(beNil())

                expect(PDFContainer.contentLeft).toNot(beNil())
                expect(PDFContainer.contentCenter).toNot(beNil())
                expect(PDFContainer.contentRight).toNot(beNil())

                expect(PDFContainer.footerLeft).toNot(beNil())
                expect(PDFContainer.footerCenter).toNot(beNil())
                expect(PDFContainer.footerRight).toNot(beNil())
            }

            it("can check if container is in header") {
                expect(PDFContainer.none.isHeader).to(beFalse())

                expect(PDFContainer.headerLeft.isHeader).to(beTrue())
                expect(PDFContainer.headerCenter.isHeader).to(beTrue())
                expect(PDFContainer.headerRight.isHeader).to(beTrue())

                expect(PDFContainer.contentLeft.isHeader).to(beFalse())
                expect(PDFContainer.contentCenter.isHeader).to(beFalse())
                expect(PDFContainer.contentRight.isHeader).to(beFalse())

                expect(PDFContainer.footerLeft.isHeader).to(beFalse())
                expect(PDFContainer.footerCenter.isHeader).to(beFalse())
                expect(PDFContainer.footerRight.isHeader).to(beFalse())
            }

            it("can check if container is in footer") {
                expect(PDFContainer.none.isFooter).to(beFalse())

                expect(PDFContainer.headerLeft.isFooter).to(beFalse())
                expect(PDFContainer.headerCenter.isFooter).to(beFalse())
                expect(PDFContainer.headerRight.isFooter).to(beFalse())

                expect(PDFContainer.contentLeft.isFooter).to(beFalse())
                expect(PDFContainer.contentCenter.isFooter).to(beFalse())
                expect(PDFContainer.contentRight.isFooter).to(beFalse())

                expect(PDFContainer.footerLeft.isFooter).to(beTrue())
                expect(PDFContainer.footerCenter.isFooter).to(beTrue())
                expect(PDFContainer.footerRight.isFooter).to(beTrue())
            }

            it("can check if container is on the left") {
                expect(PDFContainer.none.isLeft).to(beFalse())

                expect(PDFContainer.headerLeft.isLeft).to(beTrue())
                expect(PDFContainer.headerCenter.isLeft).to(beFalse())
                expect(PDFContainer.headerRight.isLeft).to(beFalse())

                expect(PDFContainer.contentLeft.isLeft).to(beTrue())
                expect(PDFContainer.contentCenter.isLeft).to(beFalse())
                expect(PDFContainer.contentRight.isLeft).to(beFalse())

                expect(PDFContainer.footerLeft.isLeft).to(beTrue())
                expect(PDFContainer.footerCenter.isLeft).to(beFalse())
                expect(PDFContainer.footerRight.isLeft).to(beFalse())
            }

            it("can check if container is on the right") {
                expect(PDFContainer.none.isRight).to(beFalse())

                expect(PDFContainer.headerLeft.isRight).to(beFalse())
                expect(PDFContainer.headerCenter.isRight).to(beFalse())
                expect(PDFContainer.headerRight.isRight).to(beTrue())

                expect(PDFContainer.contentLeft.isRight).to(beFalse())
                expect(PDFContainer.contentCenter.isRight).to(beFalse())
                expect(PDFContainer.contentRight.isRight).to(beTrue())

                expect(PDFContainer.footerLeft.isRight).to(beFalse())
                expect(PDFContainer.footerCenter.isRight).to(beFalse())
                expect(PDFContainer.footerRight.isRight).to(beTrue())
            }

            it("can return an array with all values") {
                expect(PDFContainer.all) == [
                    PDFContainer.headerLeft, PDFContainer.headerCenter, PDFContainer.headerRight,
                    PDFContainer.contentLeft, PDFContainer.contentCenter, PDFContainer.contentRight,
                    PDFContainer.footerLeft, PDFContainer.footerCenter, PDFContainer.footerRight,
                ]
            }

            context("JSON") {

                it("can be represented") {
                    expect(PDFContainer.headerCenter.JSONRepresentation as? Int) == 2
                }
            }
        }
    }

}
