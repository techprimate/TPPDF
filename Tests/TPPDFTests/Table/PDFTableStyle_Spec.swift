//
//  PDFTableStyle_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 13/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Nimble
import Quick
@testable import TPPDF

class PDFTableStyle_Spec: QuickSpec {
    override func spec() {
        describe("PDFTableStyle") {
            context("variables") {
                let style = PDFTableStyle()

                it("has a row header count") {
                    expect(style.rowHeaderCount).toNot(beNil())
                }

                it("has a column header count") {
                    expect(style.columnHeaderCount).toNot(beNil())
                }

                it("has a footer count") {
                    expect(style.footerCount).toNot(beNil())
                }

                it("has a outline") {
                    expect(style.outline).toNot(beNil())
                }

                it("has a row header style") {
                    expect(style.rowHeaderStyle).toNot(beNil())
                }

                it("has a column header style") {
                    expect(style.columnHeaderStyle).toNot(beNil())
                }

                it("has a footer style") {
                    expect(style.footerStyle).toNot(beNil())
                }

                it("has a content style") {
                    expect(style.contentStyle).toNot(beNil())
                }

                it("has an alternating content style") {
                    expect(style.alternatingContentStyle).to(beNil())
                }
            }

            context("initializer") {
                it("can be initialized with default values") {
                    let style = PDFTableStyle()

                    expect(style.rowHeaderCount) == 1
                    expect(style.columnHeaderCount) == 1
                    expect(style.footerCount) == 1
                    expect(style.outline) == PDFLineStyle()
                    expect(style.rowHeaderStyle) == PDFTableCellStyle()
                    expect(style.columnHeaderStyle) == PDFTableCellStyle()
                    expect(style.footerStyle) == PDFTableCellStyle()
                    expect(style.contentStyle) == PDFTableCellStyle()
                    expect(style.alternatingContentStyle).to(beNil())
                }

                it("can be initialized with values") {
                    let rowHeaderCount = 4
                    let columnHeaderCount = 4
                    let footerCount = 4

                    let outline = PDFLineStyle(type: .dashed, color: .orange, width: 1.25)
                    let rowHeaderStyle = PDFTableCellStyle(colors: (fill: Color.blue, text: Color.green),
                                                           borders: PDFTableCellBorders(),
                                                           font: Font.systemFont(ofSize: 10))
                    let columnHeaderStyle = PDFTableCellStyle(colors: (fill: Color.black, text: Color.green),
                                                              borders: PDFTableCellBorders(),
                                                              font: Font.systemFont(ofSize: 12))
                    let footerStyle = PDFTableCellStyle(colors: (fill: Color.purple, text: Color.green),
                                                        borders: PDFTableCellBorders(),
                                                        font: Font.systemFont(ofSize: 15))
                    let contentStyle = PDFTableCellStyle(colors: (fill: Color.blue, text: Color.orange),
                                                         borders: PDFTableCellBorders(),
                                                         font: Font.systemFont(ofSize: 10))
                    let alternatingContentStyle = PDFTableCellStyle(colors: (fill: Color.red, text: Color.green),
                                                                    borders: PDFTableCellBorders(),
                                                                    font: Font.systemFont(ofSize: 15))

                    let style = PDFTableStyle(
                        rowHeaderCount: rowHeaderCount,
                        columnHeaderCount: columnHeaderCount,
                        footerCount: footerCount,
                        outline: outline,
                        rowHeaderStyle: rowHeaderStyle,
                        columnHeaderStyle: columnHeaderStyle,
                        footerStyle: footerStyle,
                        contentStyle: contentStyle,
                        alternatingContentStyle: alternatingContentStyle
                    )

                    expect(style.rowHeaderCount) == rowHeaderCount
                    expect(style.columnHeaderCount) == columnHeaderCount
                    expect(style.footerCount) == footerCount
                    expect(style.outline) == outline
                    expect(style.rowHeaderStyle) == rowHeaderStyle
                    expect(style.columnHeaderStyle) == columnHeaderStyle
                    expect(style.footerStyle) == footerStyle
                    expect(style.contentStyle) == contentStyle
                    expect(style.alternatingContentStyle) == alternatingContentStyle
                }
            }

            it("can be copied") {
                let rowHeaderCount = 4
                let columnHeaderCount = 4
                let footerCount = 4

                let outline = PDFLineStyle(type: .dashed, color: .orange, width: 1.25)
                let rowHeaderStyle = PDFTableCellStyle(colors: (fill: Color.blue, text: Color.green),
                                                       borders: PDFTableCellBorders(),
                                                       font: Font.systemFont(ofSize: 10))
                let columnHeaderStyle = PDFTableCellStyle(colors: (fill: Color.black, text: Color.green),
                                                          borders: PDFTableCellBorders(),
                                                          font: Font.systemFont(ofSize: 12))
                let footerStyle = PDFTableCellStyle(colors: (fill: Color.purple, text: Color.green),
                                                    borders: PDFTableCellBorders(),
                                                    font: Font.systemFont(ofSize: 15))
                let contentStyle = PDFTableCellStyle(colors: (fill: Color.blue, text: Color.orange),
                                                     borders: PDFTableCellBorders(),
                                                     font: Font.systemFont(ofSize: 10))
                let alternatingContentStyle = PDFTableCellStyle(colors: (fill: Color.red, text: Color.green),
                                                                borders: PDFTableCellBorders(),
                                                                font: Font.systemFont(ofSize: 15))

                let style = PDFTableStyle(
                    rowHeaderCount: rowHeaderCount,
                    columnHeaderCount: columnHeaderCount,
                    footerCount: footerCount,
                    outline: outline,
                    rowHeaderStyle: rowHeaderStyle,
                    columnHeaderStyle: columnHeaderStyle,
                    footerStyle: footerStyle,
                    contentStyle: contentStyle,
                    alternatingContentStyle: alternatingContentStyle
                )
                let copy = style.copy()

                expect(copy).toNot(be(style))

                expect(copy.rowHeaderCount) == rowHeaderCount
                expect(copy.columnHeaderCount) == columnHeaderCount
                expect(copy.footerCount) == footerCount
                expect(copy.outline) == outline
                expect(copy.rowHeaderStyle) == rowHeaderStyle
                expect(copy.columnHeaderStyle) == columnHeaderStyle
                expect(copy.footerStyle) == footerStyle
                expect(copy.contentStyle) == contentStyle
                expect(copy.alternatingContentStyle) == alternatingContentStyle
            }
        }
    }
}
