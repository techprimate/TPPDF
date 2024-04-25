//
//  PDFGenerator_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 09/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Nimble
import Quick
@testable import TPPDF

class PDFGenerator_Spec: QuickSpec {
    override func spec() {
        describe("PDFGenerator") {
            let document = PDFDocument(format: .a4)
            let generator = PDFGenerator(document: document)

            context("variables") {
                it("has a document") {
                    expect(generator.document).toNot(beNil())
                }

                it("has a header footer objects list") {
                    expect(generator.headerFooterObjects).to(beEmpty())
                }

                it("has a layout") {
                    expect(generator.layout) == PDFLayout()
                }

                it("has a currentPage and a totalPages") {
                    expect(generator.currentPage) == 1
                    expect(generator.totalPages) == 1
                }

                it("has a lazy font per container dictionary") {
                    expect(generator.fonts[PDFContainer.none]) == Font.systemFont(ofSize: PDFConstants.defaultFontSize)
                    expect(generator.fonts[PDFContainer.headerLeft]) == Font.systemFont(ofSize: PDFConstants.defaultFontSize)
                    expect(generator.fonts[PDFContainer.headerCenter]) == Font.systemFont(ofSize: PDFConstants.defaultFontSize)
                    expect(generator.fonts[PDFContainer.headerRight]) == Font.systemFont(ofSize: PDFConstants.defaultFontSize)
                    expect(generator.fonts[PDFContainer.contentLeft]) == Font.systemFont(ofSize: PDFConstants.defaultFontSize)
                    expect(generator.fonts[PDFContainer.contentCenter]) == Font.systemFont(ofSize: PDFConstants.defaultFontSize)
                    expect(generator.fonts[PDFContainer.contentRight]) == Font.systemFont(ofSize: PDFConstants.defaultFontSize)
                    expect(generator.fonts[PDFContainer.footerLeft]) == Font.systemFont(ofSize: PDFConstants.defaultFontSize)
                    expect(generator.fonts[PDFContainer.footerCenter]) == Font.systemFont(ofSize: PDFConstants.defaultFontSize)
                    expect(generator.fonts[PDFContainer.footerRight]) == Font.systemFont(ofSize: PDFConstants.defaultFontSize)
                }
            }

            it("can be resetted") {
                generator.currentPage = 20
                generator.layout.heights.add(30, to: .contentLeft)
                generator.layout.indentation.setLeft(indentation: 45, in: .contentLeft)

                generator.resetGenerator()

                expect(generator.currentPage) == 1
                expect(generator.layout.heights) == PDFLayoutHeights()
                expect(generator.layout.indentation) == PDFLayoutIndentations()
            }
        }
    }
}
