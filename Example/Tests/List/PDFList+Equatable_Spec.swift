//
//  PDFList+Equatable_Spec.swift
//  TPPDF_Example
//
//  Created by Philip Niedertscheider on 05.12.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFList_Equatable_Spec: QuickSpec {

    override func spec() {
        describe("PDFList") {

            context("Equatable") {

                var object: PDFList!

                beforeEach {
                    object = PDFList(indentations: [(pre: 5, past: 10)])
                }

                it("is equal") {
                    let otherObject = PDFList(indentations: [(pre: 5, past: 10)])
                    expect(object) == otherObject
                }

                it("is not equal with different indentations") {
                    let otherObject = PDFList(indentations: [(pre: 10.0, past: 20.0)])
                    expect(object) != otherObject

                    otherObject.levelIndentations.append((pre: 10.0, past: 10.0))
                    expect(object) != otherObject
                }

                it("is not equal with different items") {
                    let otherObject = PDFList(indentations: [(pre: 5, past: 10)])

                    otherObject.addItem(PDFListItem(symbol: .dash, content: "CONTENT"))
                    expect(object) != otherObject

                    object.addItem(PDFListItem(symbol: .dash, content: "ANOTHERONE"))
                    expect(object) != otherObject
                }
            }
        }
    }

}
