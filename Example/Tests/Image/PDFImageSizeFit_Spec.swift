//
//  PDFImageSizeFit_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 13/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFImageSizeFit_Spec: QuickSpec {

    override func spec() {
        describe("PDFImageSizeFit") {

            it("should have enum values") {
                expect(PDFImageSizeFit.width).toNot(beNil())
                expect(PDFImageSizeFit.height).toNot(beNil())
                expect(PDFImageSizeFit.widthHeight).toNot(beNil())
            }

            context("JSONSerializable") {

                it("can be represented") {
                    expect(PDFImageSizeFit.width.JSONRepresentation as? Int) == PDFImageSizeFit.width.hashValue
                    expect(PDFImageSizeFit.height.JSONRepresentation as? Int) == PDFImageSizeFit.height.hashValue
                    expect(PDFImageSizeFit.widthHeight.JSONRepresentation as? Int) == PDFImageSizeFit.widthHeight.hashValue
                }
            }
        }
    }

}
