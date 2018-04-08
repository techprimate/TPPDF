//
//  PDFTableStyle+Defaults_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 13/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFTableStyle_Defaults_Spec: QuickSpec {

    override func spec() {
        describe("PDFTableStyle") {

            context("Defaults") {

                it("has a simple style") {
                    let darkGray = UIColor(red: 59.0 / 255.0, green: 59.0 / 255.0, blue: 59.0 / 255.0, alpha: 1.0)

                    let simple = PDFTableStyleDefaults.simple

                    expect(simple.rowHeaderCount) == 1
                    expect(simple.columnHeaderCount) == 1
                    expect(simple.footerCount) == 0

                    expect(simple.outline) == PDFLineStyle(type: .full, color: UIColor.darkGray, width: 1.0)
                    expect(simple.rowHeaderStyle) == PDFTableCellStyle(
                        colors: (fill: UIColor.white, text: darkGray),
                        borders: PDFTableCellBorders(bottom: PDFLineStyle(
                            type: .full,
                            color: UIColor.lightGray,
                            width: 0.5
                        )),
                        font: UIFont.boldSystemFont(ofSize: 12.0)
                    )
                    expect(simple.columnHeaderStyle) == PDFTableCellStyle(
                        colors: (
                            fill: UIColor(red: 83.0 / 255.0, green: 171.0 / 255.0, blue: 104.0 / 255.0, alpha: 1.0),
                            text: UIColor.white
                        ),
                        borders: PDFTableCellBorders(),
                        font: UIFont.boldSystemFont(ofSize: 14)
                    )
                    expect(simple.contentStyle) == PDFTableCellStyle(
                        colors: (
                            fill: UIColor(red: 246.0 / 255.0, green: 246.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0),
                            text: darkGray
                        ),
                        borders: PDFTableCellBorders(),
                        font: UIFont.systemFont(ofSize: 14)
                    )
                    expect(simple.alternatingContentStyle) == PDFTableCellStyle(
                        colors: (
                            fill: UIColor(red: 233.0 / 255.0, green: 233.0 / 255.0, blue: 233.0 / 255.0, alpha: 1.0),
                            text: darkGray
                        ),
                        borders: PDFTableCellBorders(),
                        font: UIFont.systemFont(ofSize: 14)
                    )
                }
            }
        }
    }

}
