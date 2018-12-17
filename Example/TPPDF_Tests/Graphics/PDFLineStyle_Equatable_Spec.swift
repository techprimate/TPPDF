//
//  PDFLineStyle_Equatable_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 12/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//


import Quick
import Nimble
@testable import TPPDF

class PDFLineStyle_Equatable_Spec: QuickSpec {

    override func spec() {
        describe("PDFLineStyle") {

            context("Equatable") {

                it("is equal") {
                    let style1 = PDFLineStyle(type: .dotted, color: .orange, width: 0.25)
                    let style2 = PDFLineStyle(type: .dotted, color: .orange, width: 0.25)

                    expect(style1) == style2
                }

                it("is not equal with different line typ") {
                    let style1 = PDFLineStyle(type: .dotted, color: .orange, width: 0.25)
                    let style2 = PDFLineStyle(type: .dashed, color: .orange, width: 0.25)

                    expect(style1) != style2
                }

                it("is not equal with different color") {
                    let style1 = PDFLineStyle(type: .dotted, color: .orange, width: 0.25)
                    let style2 = PDFLineStyle(type: .dotted, color: .red, width: 0.25)

                    expect(style1) != style2
                }

                it("is not equal with different width") {
                    let style1 = PDFLineStyle(type: .dotted, color: .orange, width: 0.25)
                    let style2 = PDFLineStyle(type: .dotted, color: .orange, width: 1.0)

                    expect(style1) != style2
                }
            }
        }
    }

}
