//
//  PDFLayout+Equatable_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 14/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFLayout_Equatable_Spec: QuickSpec {

    override func spec() {
        describe("PDFLayout") {

            context("Equatable") {

                let layout = PDFLayout()

                it("is equal") {
                    let otherLayout = PDFLayout()
                    expect(layout) == otherLayout
                }

                it("is not equal with different heights") {
                    let otherLayout = PDFLayout()
                    otherLayout.heights.content = 123

                    expect(layout) != otherLayout
                }

                it("is not equal with different indentation") {
                    let otherLayout = PDFLayout()
                    otherLayout.indentation.header.left = 100

                    expect(layout) != otherLayout
                }
            }
        }
    }

}
