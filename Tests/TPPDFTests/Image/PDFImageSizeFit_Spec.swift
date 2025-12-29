//
//  PDFImageSizeFit_Spec.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.13.2017.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

import Nimble
import Quick
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
