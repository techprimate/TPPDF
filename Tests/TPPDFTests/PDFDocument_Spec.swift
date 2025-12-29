//
//  PDFDocument_Spec.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.04.2017.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

import Nimble
import Quick
@testable import TPPDF

class PDFDocument_Spec: QuickSpec {
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

            it("can be initialized with a page format") {
                document = PDFDocument(format: .a4)
                expect(document.layout) == PDFPageFormat.a4.layout
            }

            context("variables") {
                it("should have layout") {
                    expect(document.layout).toNot(beNil())
                }

                it("should have info with default value") {
                    expect(document.info) == PDFInfo()
                }

                it("should have pagination with default value") {
                    expect(document.pagination) == PDFPagination()
                }

                it("should have array of objects") {
                    expect(document.objects).to(haveCount(0))
                }
            }
        }
    }
}
