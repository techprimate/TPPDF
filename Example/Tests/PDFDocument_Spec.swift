//
//  PDFDocument_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 04/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFDocument_Spec : QuickSpec {

    override func spec() {
        describe("PDFDocument") {
            let layout = PDFPageLayout()
            var document: PDFDocument!

            beforeEach {
                document = PDFDocument(layout: layout)
            }

            it("should be initialized with a layout") {
                expect(document.layout) == layout
            }

            context("variables") {

                it("should have a default info") {
                    expect(document.info) == PDFInfo()
                }

                it("should have a default pagina") {
                    expect(document.pagination) == PDFPagination()
                }
            }
        }
    }
}
