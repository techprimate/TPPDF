//
//  PDFLayoutIndentations+Equatable_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 14/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFLayoutIndentations_Equatable_Spec: QuickSpec {

    override func spec() {
        describe("PDFLayoutIndentations") {

            context("Equatable") {

                let indentation = PDFLayoutIndentations()

                it("is equal") {
                    let otherIndentation = PDFLayoutIndentations()
                    expect(indentation) == otherIndentation
                }

                it("is not equal with different header") {
                    var otherIndentation = PDFLayoutIndentations()
                    otherIndentation.header = (10, 20)
                    expect(indentation) != otherIndentation
                }

                it("is not equal with different footer") {
                    var otherIndentation = PDFLayoutIndentations()
                    otherIndentation.content = (10, 20)
                    expect(indentation) != otherIndentation
                }

                it("is not equal with different content value") {
                    var otherIndentation = PDFLayoutIndentations()
                    otherIndentation.footer = (10, 20)
                    expect(indentation) != otherIndentation
                }
            }
        }
    }

}
