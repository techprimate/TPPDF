//
//  PDFLayoutHeights_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 05/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFLayoutHeights_Spec: QuickSpec {

    override func spec() {
        describe("PDFLayoutHeights") {

            var heights: PDFLayoutHeights!

            beforeEach {
                heights = PDFLayoutHeights()
            }

            context("variables") {

                it("has default values per header container") {
                    expect(heights.header) == [
                        PDFContainer.headerLeft: 0,
                        PDFContainer.headerCenter: 0,
                        PDFContainer.headerRight: 0
                    ]
                }

                it("has default values per footer container") {
                    expect(heights.footer) == [
                        PDFContainer.footerLeft: 0,
                        PDFContainer.footerCenter: 0,
                        PDFContainer.footerRight: 0
                    ]
                }

                it("has a default content value") {
                    expect(heights.content) == 0
                }
            }

            it("can find max header height") {
                let max: CGFloat = 4
                heights.header = [
                    PDFContainer.headerLeft: 2,
                    PDFContainer.headerCenter: 3,
                    PDFContainer.headerRight: max
                ]
                expect(heights.maxHeaderHeight()) == max
            }

            it("returns zero for max header when missing values") {
                heights.header = [:]
                expect(heights.maxHeaderHeight()) == 0
            }

            it("returns zero for max footer when missing values") {
                heights.footer = [:]
                expect(heights.maxFooterHeight()) == 0
            }

            it("can add value to a container") {
                heights.header = [
                    PDFContainer.headerLeft: 10,
                    PDFContainer.headerCenter: 20,
                    PDFContainer.headerRight: 30
                ]
                heights.footer = [
                    PDFContainer.footerLeft: 40,
                    PDFContainer.footerCenter: 50,
                    PDFContainer.footerRight: 60
                ]
                heights.content = 70

                heights.add(10, to: .headerLeft)
                expect(heights.header[PDFContainer.headerLeft]) == 20

                heights.add(10, to: .headerCenter)
                expect(heights.header[PDFContainer.headerCenter]) == 30

                heights.add(10, to: .headerRight)
                expect(heights.header[PDFContainer.headerRight]) == 40


                heights.add(10, to: .footerLeft)
                expect(heights.footer[PDFContainer.footerLeft]) == 50

                heights.add(10, to: .footerCenter)
                expect(heights.footer[PDFContainer.footerCenter]) == 60

                heights.add(10, to: .footerRight)
                expect(heights.footer[PDFContainer.footerRight]) == 70

                heights.add(10, to: PDFContainer.contentLeft)
                expect(heights.content) == 80

                heights.add(10, to: PDFContainer.contentCenter)
                expect(heights.content) == 90

                heights.add(10, to: PDFContainer.contentRight)
                expect(heights.content) == 100
            }

            it("sets value when can not add") {
                heights.header = [:]
                heights.footer = [:]

                heights.add(10, to: .headerLeft)
                expect(heights.header[PDFContainer.headerLeft]) == 10

                heights.add(20, to: .footerLeft)
                expect(heights.footer[PDFContainer.footerLeft]) == 20
            }
        }
    }

}
