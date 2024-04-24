//
//  PDFPageBreakObject+Equatable_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 14/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Nimble
import Quick
@testable import TPPDF

class PDFPageBreakObject_Equatable_Spec: QuickSpec {
    override func spec() {
        describe("PDFPageBreakObject") {
            context("Equatable") {
                let object = PDFPageBreakObject()

                it("is equal") {
                    let otherObject = PDFPageBreakObject()
                    expect(object) == otherObject
                }
            }
        }
    }
}
