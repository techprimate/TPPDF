//
//  EmptyDocumentTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 04.01.2021.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

import Foundation
import Nimble
import Quick
@testable import TPPDF

#if canImport(PDFKit)
import PDFKit

@available(iOS 11.0, *)
class EmptyDocumentTests: QuickSpec {
    override func spec() {
        describe("Empty Document") {
            it("it should have a single page") {
                let document = PDFDocument(format: .usLetter)
                let generator = PDFGenerator(document: document)
                generator.debug = true

                var outputURL: URL! = nil
                expect {
                    outputURL = try generator.generateURL(filename: "output.pdf")
                }.toNot(throwError())
                expect(generator.totalPages) == 1

                let outputDoc = PDFKit.PDFDocument(url: outputURL)
                expect(outputDoc?.pageCount) == 1
            }
        }
    }
}
#endif
