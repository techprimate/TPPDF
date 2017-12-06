//
//  PDFError_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 06.12.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFError_Spec: QuickSpec {

    override func spec() {
        describe("PDFError") {

            it("should have enum values") {
                expect(PDFError.tableContentInvalid(value: nil)).toNot(beNil())

                expect(PDFError.tableIsEmpty).toNot(beNil())
                expect(PDFError.tableStructureInvalid(message: "MESSAGE")).toNot(beNil())
                expect(PDFError.tableIndexOutOfBounds(index: 5, length: 4)).toNot(beNil())
                expect(PDFError.tableCellWeakReferenceBroken).toNot(beNil())

                expect(PDFError.textObjectIsNil).toNot(beNil())

                expect(PDFError.invalidHexLength(length: 7)).toNot(beNil())
                expect(PDFError.invalidHex(hex: "ABCD")).toNot(beNil())
            }
        }
    }
}
