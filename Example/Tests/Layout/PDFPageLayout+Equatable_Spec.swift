//
//  PDFPageLayout+Equatable_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 14/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFPageLayout_Equatable_Spec: QuickSpec {

    override func spec() {
        describe("PDFPageLayout") {

            context("Equatable") {

                var object: PDFPageLayout!

                beforeEach {
                    object = PDFPageLayout()
                }

                it("is equal") {
                    let otherObject = PDFPageLayout()
                    expect(object) == otherObject
                }

                it("is not equal with different size") {
                    var otherObject = PDFPageLayout()

                    otherObject.size = CGSize(width: 20, height: 30)
                    object.size = CGSize(width: 50, height: 10)

                    expect(object) != otherObject
                }

                it("is not equal with different margin") {
                    var otherObject = PDFPageLayout()

                    object.margin = UIEdgeInsets(top: 40, left: 30, bottom: 20, right: 10)
                    otherObject.margin = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)

                    expect(object) != otherObject
                }

                it("is not equal with different space") {
                    var otherObject = PDFPageLayout()

                    otherObject.space.footer = 100
                    object.space.footer = 150

                    expect(object) != otherObject
                }
            }
        }
    }

}
