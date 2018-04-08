//
//  PDFLineType_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 04/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFLineType_Spec: QuickSpec {

    override func spec() {
        describe("PDFLineType") {

            it("can create a JSON representable") {
                expect(PDFLineType.none.JSONRepresentation as? Int) == 0
                expect(PDFLineType.full.JSONRepresentation as? Int) == 1
                expect(PDFLineType.dashed.JSONRepresentation as? Int) == 2
                expect(PDFLineType.dotted.JSONRepresentation as? Int) == 3
            }
        }
    }

}
