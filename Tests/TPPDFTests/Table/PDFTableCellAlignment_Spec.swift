//
//  PDFTableCellAlignment_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 12/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFTableCellAlignment_Spec: QuickSpec {

    override func spec() {
        describe("PDFTableCellAlignment") {

            context("enum values") {

                it("has topLeft") {
                    expect(PDFTableCellAlignment.topLeft).toNot(beNil())
                }

                it("has top") {
                    expect(PDFTableCellAlignment.top).toNot(beNil())
                }

                it("has topRight") {
                    expect(PDFTableCellAlignment.topRight).toNot(beNil())
                }

                it("has left") {
                    expect(PDFTableCellAlignment.left).toNot(beNil())
                }

                it("has center") {
                    expect(PDFTableCellAlignment.center).toNot(beNil())
                }

                it("has right") {
                    expect(PDFTableCellAlignment.right).toNot(beNil())
                }

                it("has bottomLeft") {
                    expect(PDFTableCellAlignment.bottomLeft).toNot(beNil())
                }

                it("has bottom") {
                    expect(PDFTableCellAlignment.bottom).toNot(beNil())
                }

                it("has bottomRight") {
                    expect(PDFTableCellAlignment.bottomRight).toNot(beNil())
                }
            }

            it("has a method to check if it is at top") {
                expect(PDFTableCellAlignment.topLeft.isTop).to(beTrue())
                expect(PDFTableCellAlignment.top.isTop).to(beTrue())
                expect(PDFTableCellAlignment.topRight.isTop).to(beTrue())

                expect(PDFTableCellAlignment.left.isTop).to(beFalse())
                expect(PDFTableCellAlignment.center.isTop).to(beFalse())
                expect(PDFTableCellAlignment.right.isTop).to(beFalse())

                expect(PDFTableCellAlignment.bottomLeft.isTop).to(beFalse())
                expect(PDFTableCellAlignment.bottom.isTop).to(beFalse())
                expect(PDFTableCellAlignment.bottomRight.isTop).to(beFalse())
            }

            it("has a method to check if it is at bottom") {
                expect(PDFTableCellAlignment.topLeft.isBottom).to(beFalse())
                expect(PDFTableCellAlignment.top.isBottom).to(beFalse())
                expect(PDFTableCellAlignment.topRight.isBottom).to(beFalse())

                expect(PDFTableCellAlignment.left.isBottom).to(beFalse())
                expect(PDFTableCellAlignment.center.isBottom).to(beFalse())
                expect(PDFTableCellAlignment.right.isBottom).to(beFalse())

                expect(PDFTableCellAlignment.bottomLeft.isBottom).to(beTrue())
                expect(PDFTableCellAlignment.bottom.isBottom).to(beTrue())
                expect(PDFTableCellAlignment.bottomRight.isBottom).to(beTrue())
            }

            it("has a method to check if it is at left") {
                expect(PDFTableCellAlignment.topLeft.isLeft).to(beTrue())
                expect(PDFTableCellAlignment.top.isLeft).to(beFalse())
                expect(PDFTableCellAlignment.topRight.isLeft).to(beFalse())

                expect(PDFTableCellAlignment.left.isLeft).to(beTrue())
                expect(PDFTableCellAlignment.center.isLeft).to(beFalse())
                expect(PDFTableCellAlignment.right.isLeft).to(beFalse())

                expect(PDFTableCellAlignment.bottomLeft.isLeft).to(beTrue())
                expect(PDFTableCellAlignment.bottom.isLeft).to(beFalse())
                expect(PDFTableCellAlignment.bottomRight.isLeft).to(beFalse())
            }

            it("has a method to check if it is at right") {
                expect(PDFTableCellAlignment.topLeft.isRight).to(beFalse())
                expect(PDFTableCellAlignment.top.isRight).to(beFalse())
                expect(PDFTableCellAlignment.topRight.isRight).to(beTrue())

                expect(PDFTableCellAlignment.left.isRight).to(beFalse())
                expect(PDFTableCellAlignment.center.isRight).to(beFalse())
                expect(PDFTableCellAlignment.right.isRight).to(beTrue())

                expect(PDFTableCellAlignment.bottomLeft.isRight).to(beFalse())
                expect(PDFTableCellAlignment.bottom.isRight).to(beFalse())
                expect(PDFTableCellAlignment.bottomRight.isRight).to(beTrue())
            }

            it("can be representated") {
                expect(PDFTableCellAlignment.topLeft.JSONRepresentation as? Int) == 0
                expect(PDFTableCellAlignment.top.JSONRepresentation as? Int) == 1
                expect(PDFTableCellAlignment.topRight.JSONRepresentation as? Int) == 2

                expect(PDFTableCellAlignment.left.JSONRepresentation as? Int) == 3
                expect(PDFTableCellAlignment.center.JSONRepresentation as? Int) == 4
                expect(PDFTableCellAlignment.right.JSONRepresentation as? Int) == 5

                expect(PDFTableCellAlignment.bottomLeft.JSONRepresentation as? Int) == 6
                expect(PDFTableCellAlignment.bottom.JSONRepresentation as? Int) == 7
                expect(PDFTableCellAlignment.bottomRight.JSONRepresentation as? Int) == 8
            }
        }
    }

}
