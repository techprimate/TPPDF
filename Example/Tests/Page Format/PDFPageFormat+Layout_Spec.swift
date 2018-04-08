//
//  PDFPageFormat+Layout_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 27.12.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFPageFormat_Layout_Spec: QuickSpec {

    override func spec() {
        describe("PDFPageFormat") {

            context("layout") {

                it("has a shorthand method to creaet a PDFPageLayout") {
                    expect(PDFPageFormat.a0.layout) == PDFPageLayout(size: CGSize(width: 2384, height: 3370),
                                                                     margin: UIEdgeInsets(
                                                                        top: 60.0,
                                                                        left: 60.0,
                                                                        bottom: 60.0,
                                                                        right: 60.0),
                                                                     space: (header: 15, footer: 15))
                }
            }
        }
    }

}
