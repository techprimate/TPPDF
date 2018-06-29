//
//  PDFListItem_Equatable_Spec.swift
//  TPPDF_Example
//
//  Created by Philip Niedertscheider on 05.12.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFListItem_Equatable_Spec: QuickSpec {

    override func spec() {
        describe("PDFListItem") {

            context("Equatable") {

                var object: PDFListItem!

                beforeEach {
                    object = PDFListItem()
                }

                it("is equal") {
                    let otherObject = PDFListItem()
                    expect(object) == otherObject
                }

                it("is not equal with different parents") {
                    let otherObject = PDFListItem()
                    let otherParent = PDFListItem()
                    
                    otherObject.parent = otherParent

                    expect(object) != otherObject
                }

                it("is not equal with different content") {
                    let otherObject = PDFListItem()

                    otherObject.content = "RANDOM"

                    expect(object) != otherObject
                }

                it("is not equal with different children") {
                    let otherObject = PDFListItem()

                    otherObject.children = [PDFListItem()]

                    expect(object) != otherObject
                }

                it("is not equal with different symbol") {
                    let otherObject = PDFListItem()

                    otherObject.symbol = PDFListItemSymbol.custom(value: "RANDOM")

                    expect(object) != otherObject
                }
            }
        }
    }

}
