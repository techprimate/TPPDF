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
                    let position1 = PDFTableCellPosition(row: 1, column: 2)
                    let position2 = PDFTableCellPosition(row: 4, column: 9)
                    expect(position1.hashValue) == position1.hashValue
                    expect(position1.hashValue) != position2.hashValue
                }
            }
        }
    }

}
