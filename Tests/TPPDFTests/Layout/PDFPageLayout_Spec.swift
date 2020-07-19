//
//  PDFPageLayout_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 14/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import CoreGraphics
import Quick
import Nimble
@testable import TPPDF

class PDFPageLayout_Spec: QuickSpec {

    override func spec() {
        describe("PDFPageLayout") {

            var layout: PDFPageLayout!

            beforeEach {
                layout = PDFPageLayout()
            }

            context("variables") {

                it("has default value size") {
                    expect(layout.size) == CGSize.zero
                }

                it("has default value margin") {
                    expect(layout.margin) == EdgeInsets.zero
                }

                it("has a default value space") {
                    expect(layout.space.footer) == 0
                    expect(layout.space.header) == 0
                }
            }

            context("computed variables") {

                it("has a value bounds") {
                    layout.size = CGSize(width: 10, height: 20)
                    expect(layout.bounds) == CGRect(x: 0, y: 0, width: 10, height: 20)
                }

                it("has a value width") {
                    layout.size = CGSize(width: 10, height: 20)
                    expect(layout.width) == 10
                }

                it("has a value height") {
                    layout.size = CGSize(width: 10, height: 20)
                    expect(layout.height) == 20
                }
            }
        }
    }

}
