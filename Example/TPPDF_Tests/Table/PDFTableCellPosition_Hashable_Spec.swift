//
//  PDFTableCellPosition_Hashable_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 16/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFTableCellPosition_Hashable_Spec: QuickSpec {

    override func spec() {
        describe("PDFTableCellPosition") {

            context("Hashable") {

                it("can create a hashvalue") {
                    expect(PDFTableCellPosition(row: 1, column: 2).hashValue) == 1 * 1 * 10 + 2
                    expect(PDFTableCellPosition(row: 4, column: 9).hashValue) == 4 * 4 * 10 + 9
                }
            }
        }
    }

}
