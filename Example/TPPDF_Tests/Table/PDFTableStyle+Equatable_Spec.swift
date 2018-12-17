//
//  PDFTableStyle+Equatable_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 13/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFTableStyle_Equatable_Spec: QuickSpec {

    override func spec() {
        describe("PDFTableStyle") {

            context("Equatable") {

                let style = PDFTableStyle(rowHeaderCount: 1,
                                          columnHeaderCount: 2,
                                          footerCount: 3,
                                          outline: PDFLineStyle.none,
                                          rowHeaderStyle: PDFTableCellStyle(),
                                          columnHeaderStyle: PDFTableCellStyle(),
                                          footerStyle: PDFTableCellStyle(),
                                          contentStyle: PDFTableCellStyle(),
                                          alternatingContentStyle: PDFTableCellStyle())

                it("is equal") {
                    let otherStyle = PDFTableStyle(rowHeaderCount: 1,
                                              columnHeaderCount: 2,
                                              footerCount: 3,
                                              outline: PDFLineStyle.none,
                                              rowHeaderStyle: PDFTableCellStyle(),
                                              columnHeaderStyle: PDFTableCellStyle(),
                                              footerStyle: PDFTableCellStyle(),
                                              contentStyle: PDFTableCellStyle(),
                                              alternatingContentStyle: PDFTableCellStyle())

                    expect(style) == otherStyle
                }

                it("is not equal with different row header count") {
                    let otherStyle = PDFTableStyle(rowHeaderCount: 1000,
                                                   columnHeaderCount: 2,
                                                   footerCount: 3,
                                                   outline: PDFLineStyle.none,
                                                   rowHeaderStyle: PDFTableCellStyle(),
                                                   columnHeaderStyle: PDFTableCellStyle(),
                                                   footerStyle: PDFTableCellStyle(),
                                                   contentStyle: PDFTableCellStyle(),
                                                   alternatingContentStyle: PDFTableCellStyle())

                    expect(style) != otherStyle
                }

                it("is not equal with different column header count") {
                    let otherStyle = PDFTableStyle(rowHeaderCount: 1,
                                                   columnHeaderCount: 1000,
                                                   footerCount: 3,
                                                   outline: PDFLineStyle.none,
                                                   rowHeaderStyle: PDFTableCellStyle(),
                                                   columnHeaderStyle: PDFTableCellStyle(),
                                                   footerStyle: PDFTableCellStyle(),
                                                   contentStyle: PDFTableCellStyle(),
                                                   alternatingContentStyle: PDFTableCellStyle())

                    expect(style) != otherStyle
                }

                it("is not equal with different footer count") {
                    let otherStyle = PDFTableStyle(rowHeaderCount: 1,
                                                   columnHeaderCount: 2,
                                                   footerCount: 1000,
                                                   outline: PDFLineStyle.none,
                                                   rowHeaderStyle: PDFTableCellStyle(),
                                                   columnHeaderStyle: PDFTableCellStyle(),
                                                   footerStyle: PDFTableCellStyle(),
                                                   contentStyle: PDFTableCellStyle(),
                                                   alternatingContentStyle: PDFTableCellStyle())

                    expect(style) != otherStyle
                }

                it("is not equal with different outline") {
                    let otherStyle = PDFTableStyle(rowHeaderCount: 1,
                                                   columnHeaderCount: 2,
                                                   footerCount: 3,
                                                   outline: PDFLineStyle(type: .dotted, color: .orange, width: 1.0),
                                                   rowHeaderStyle: PDFTableCellStyle(),
                                                   columnHeaderStyle: PDFTableCellStyle(),
                                                   footerStyle: PDFTableCellStyle(),
                                                   contentStyle: PDFTableCellStyle(),
                                                   alternatingContentStyle: PDFTableCellStyle())

                    expect(style) != otherStyle
                }

                it("is not equal with different row header style") {
                    let otherStyle = PDFTableStyle(rowHeaderCount: 1,
                                                   columnHeaderCount: 2,
                                                   footerCount: 3,
                                                   outline: PDFLineStyle.none,
                                                   rowHeaderStyle: PDFTableCellStyle(colors: (fill: UIColor.red, text: UIColor.blue),
                                                                                     borders: PDFTableCellBorders(),
                                                                                     font: UIFont.systemFont(ofSize: 20)),
                                                   columnHeaderStyle: PDFTableCellStyle(),
                                                   footerStyle: PDFTableCellStyle(),
                                                   contentStyle: PDFTableCellStyle(),
                                                   alternatingContentStyle: PDFTableCellStyle())

                    expect(style) != otherStyle
                }

                it("is not equal with different column header style") {
                    let otherStyle = PDFTableStyle(rowHeaderCount: 1,
                                                   columnHeaderCount: 2,
                                                   footerCount: 3,
                                                   outline: PDFLineStyle.none,
                                                   rowHeaderStyle: PDFTableCellStyle(),
                                                   columnHeaderStyle: PDFTableCellStyle(colors: (fill: UIColor.red, text: UIColor.blue),
                                                                                        borders: PDFTableCellBorders(),
                                                                                        font: UIFont.systemFont(ofSize: 20)),
                                                   footerStyle: PDFTableCellStyle(),
                                                   contentStyle: PDFTableCellStyle(),
                                                   alternatingContentStyle: PDFTableCellStyle())

                    expect(style) != otherStyle
                }

                it("is not equal with different footer style") {
                    let otherStyle = PDFTableStyle(rowHeaderCount: 1,
                                                   columnHeaderCount: 2,
                                                   footerCount: 3,
                                                   outline: PDFLineStyle.none,
                                                   rowHeaderStyle: PDFTableCellStyle(),
                                                   columnHeaderStyle: PDFTableCellStyle(),
                                                   footerStyle: PDFTableCellStyle(colors: (fill: UIColor.red, text: UIColor.blue),
                                                                                  borders: PDFTableCellBorders(),
                                                                                  font: UIFont.systemFont(ofSize: 20)),
                                                   contentStyle: PDFTableCellStyle(),
                                                   alternatingContentStyle: PDFTableCellStyle())

                    expect(style) != otherStyle
                }

                it("is not equal with different content style") {
                    let otherStyle = PDFTableStyle(rowHeaderCount: 1,
                                                   columnHeaderCount: 2,
                                                   footerCount: 3,
                                                   outline: PDFLineStyle.none,
                                                   rowHeaderStyle: PDFTableCellStyle(),
                                                   columnHeaderStyle: PDFTableCellStyle(),
                                                   footerStyle: PDFTableCellStyle(),
                                                   contentStyle: PDFTableCellStyle(colors: (fill: UIColor.red, text: UIColor.blue),
                                                                                   borders: PDFTableCellBorders(),
                                                                                   font: UIFont.systemFont(ofSize: 20)),
                                                   alternatingContentStyle: PDFTableCellStyle())

                    expect(style) != otherStyle
                }

                it("is not equal with different alternatingContentStyle") {
                    let otherStyle = PDFTableStyle(rowHeaderCount: 1,
                                                   columnHeaderCount: 2,
                                                   footerCount: 3,
                                                   outline: PDFLineStyle.none,
                                                   rowHeaderStyle: PDFTableCellStyle(),
                                                   columnHeaderStyle: PDFTableCellStyle(),
                                                   footerStyle: PDFTableCellStyle(),
                                                   contentStyle: PDFTableCellStyle(),
                                                   alternatingContentStyle: nil)

                    expect(style) != otherStyle
                }
            }
        }
    }

}
