//
//  PDFOffsetObject+Equatable_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 14/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFOffsetObject_Equatable_Spec: QuickSpec {

    override func spec() {
        describe("PDFOffsetObject") {

            context("Equatable") {

                let object = PDFOffsetObject(offset: 10)

                it("is equal") {
                    let otherObject = PDFOffsetObject(offset: 10)
                    expect(object) == otherObject
                }

                it("is not equal with different offset") {
                    let otherObject = PDFOffsetObject(offset: 20)
                    expect(object) != otherObject
                }
            }
        }
    }

}
