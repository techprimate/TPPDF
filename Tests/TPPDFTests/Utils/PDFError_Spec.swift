//
//  PDFError_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 06.12.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Nimble
import Quick
@testable import TPPDF

class PDFError_Spec: QuickSpec {
    override func spec() {
        describe("PDFError") {
            it("should have enum values") {
                expect(PDFError.tableContentInvalid(value: nil)).toNot(beNil())

                expect(PDFError.tableIsEmpty).toNot(beNil())
                expect(PDFError.tableStructureInvalid(message: "MESSAGE")).toNot(beNil())
                expect(PDFError.tableIndexOutOfBounds(index: 5, length: 4)).toNot(beNil())

                expect(PDFError.textObjectIsNil).toNot(beNil())
                expect(PDFError.textObjectNotCalculated).toNot(beNil())
            }

            it("should have a localized description") {
                expect(PDFError.tableContentInvalid(value: nil).localizedDescription) == "Table content is invalid: nil"

                expect(PDFError.tableIsEmpty.localizedDescription) == "Table is empty"
                expect(PDFError.tableStructureInvalid(message: "MESSAGE").localizedDescription) == "Table structure invalid: MESSAGE"
                expect(PDFError.tableIndexOutOfBounds(index: 5, length: 4).localizedDescription) == "Table index out of bounds: <index: 5, length: 4>"

                expect(PDFError.textObjectIsNil.localizedDescription) == "No text object has been set"
                expect(PDFError.textObjectNotCalculated.localizedDescription) == "Text object is missing string, maybe not calculated?"
            }
        }
    }
}
