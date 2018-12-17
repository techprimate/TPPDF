//
//  PDFIndentationObject_Equatable_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 16/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFIndentationObject_Equatable_Spec: QuickSpec {

    override func spec() {
        describe("PDFIndentationObject") {

            context("Equatable") {

                let object = PDFIndentationObject(indentation: 0, left: true)

                it("is equal") {
                    let otherObject = PDFIndentationObject(indentation: 0, left: true)
                    expect(object) == otherObject
                }

                it("is not equal with different indentation") {
                    let otherObject = PDFIndentationObject(indentation: 10, left: true)
                    expect(object) != otherObject
                }

                it("is not equal with different left") {
                    let otherObject = PDFIndentationObject(indentation: 0, left: false)
                    expect(object) != otherObject
                }
            }
        }
    }

}
