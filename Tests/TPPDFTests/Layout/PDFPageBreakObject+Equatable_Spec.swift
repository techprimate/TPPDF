//
//  PDFPageBreakObject+Equatable_Spec.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.14.2017.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
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
