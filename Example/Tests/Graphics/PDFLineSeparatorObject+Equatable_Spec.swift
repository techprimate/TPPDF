//
//  PDFLineSeparatorObject+Equatable_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 12/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFLineSeparatorObject_Equatable_Spec: QuickSpec {

    override func spec() {
        describe("PDFLineSeparatorObject") {

            context("Equatable") {

                it("is equal") {
                    let style = PDFLineStyle(type: .dotted, color: .orange, width: 0.25)

                    expect(PDFLineSeparatorObject(style: style)) == PDFLineSeparatorObject(style: style)
                }

                it("is not equal with different style") {
                    let style1 = PDFLineStyle(type: .dotted, color: .orange, width: 0.25)
                    let style2 = PDFLineStyle(type: .dashed, color: .blue, width: 1.0)

                    expect(PDFLineSeparatorObject(style: style1)) != PDFLineSeparatorObject(style: style2)
                }
            }
        }
    }

}
