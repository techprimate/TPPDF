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
        }
    }

}
