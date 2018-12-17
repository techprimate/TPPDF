//
//  PDFLayout_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 14/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFLayout_Spec: QuickSpec {

    override func spec() {
        describe("PDFLayout") {

            var layout: PDFLayout!

            beforeEach {
                layout = PDFLayout()
            }

            context("variables") {

                it("has an default heights instance") {
                    layout.heights = PDFLayoutHeights()
                }

                it("has an default indentation instance") {
                    layout.indentation = PDFLayoutIndentations()
                }
            }

            it("can get content offset from heights") {
                let headerHeights: [PDFContainer: CGFloat] = [
                    PDFContainer.headerLeft: 1,
                    PDFContainer.headerCenter: 2,
                    PDFContainer.headerRight: 3
                ]
                layout.heights.header = headerHeights

                expect(layout.getContentOffset(in: .headerLeft)) == headerHeights[PDFContainer.headerLeft]
                expect(layout.getContentOffset(in: .headerCenter)) == headerHeights[PDFContainer.headerCenter]
                expect(layout.getContentOffset(in: .headerRight)) == headerHeights[PDFContainer.headerRight]

                let footerHeights: [PDFContainer: CGFloat] = [
                    PDFContainer.footerLeft: 1,
                    PDFContainer.footerCenter: 2,
                    PDFContainer.footerRight: 3
                ]
                layout.heights.footer = footerHeights

                expect(layout.getContentOffset(in: .footerLeft)) == footerHeights[PDFContainer.footerLeft]!
                expect(layout.getContentOffset(in: .footerCenter)) == footerHeights[PDFContainer.footerCenter]!
                expect(layout.getContentOffset(in: .footerRight)) == footerHeights[PDFContainer.footerRight]!

                let contentHeight: CGFloat = 123
                layout.heights.content = contentHeight

                expect(layout.getContentOffset(in: .contentLeft)) == contentHeight
                expect(layout.getContentOffset(in: .contentCenter)) == contentHeight
                expect(layout.getContentOffset(in: .contentRight)) == contentHeight
            }

            it("can set content offset in heights") {
                expect(PDFContainer.all).to(allPass {
                    let random = CGFloat(arc4random())
                    layout.setContentOffset(in: $0!, to: random)
                    return layout.getContentOffset(in: $0!) == random
                })
            }

            it("can be resetted") {
                layout.setContentOffset(in: .contentCenter, to: 123)
                layout.indentation.setLeft(indentation: 123, in: .contentCenter)

                let heights = layout.heights
                let indentation = layout.indentation

                layout.reset()

                expect(layout.heights) != heights
                expect(layout.indentation) != indentation
            }
        }
    }

}
