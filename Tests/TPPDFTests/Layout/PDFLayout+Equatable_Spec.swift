//
//  PDFLayout+Equatable_Spec.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.14.2017.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

import Nimble
import Quick
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
