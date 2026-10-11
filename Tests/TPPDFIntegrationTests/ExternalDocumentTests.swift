//
//  ExternalDocumentTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 03.01.2021.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Foundation
import Testing
@testable import TPPDF

#if canImport(PDFKit)
import PDFKit

struct ExternalDocumentTests {
    @Test(arguments: [
        (before: false, after: false, documents: 1, pages: 50),
        (before: true, after: false, documents: 1, pages: 51),
        (before: false, after: true, documents: 1, pages: 51),
        (before: true, after: true, documents: 1, pages: 52),
        (before: false, after: false, documents: 2, pages: 100),
        (before: false, after: false, documents: 5, pages: 250),
    ], [false, true])
    func externalDocumentsPreservePagesAndContentOrderWithDebugMode(
        scenario: (before: Bool, after: Bool, documents: Int, pages: Int), debug: Bool
    ) throws {
        // Arrange
        let url = try #require(Bundle.module.url(forResource: "50-pages", withExtension: "pdf"))
        let sourceDocument = PDFKit.PDFDocument(url: url)
        let source = try #require(sourceDocument)
        let document = TPPDF.PDFDocument(format: .a4)
        if scenario.before {
            document.add(text: "Text before external document")
        }
        for _ in 0..<scenario.documents {
            document.add(externalDocument: .init(url: url))
        }
        if scenario.after {
            document.add(text: "Text after external document")
        }
        let generator = PDFGenerator(document: document)
        generator.debug = debug

        // Act
        let data = try generator.generateData()
        let outputDocument = PDFKit.PDFDocument(data: data)
        let output = try #require(outputDocument)

        // Assert
        #expect(generator.totalPages == scenario.pages)
        try #require(output.pageCount == scenario.pages)
        let externalStart = scenario.before ? 1 : 0
        if scenario.before {
            #expect(output.page(at: 0)?.string?.contains("Text before external document") == true)
        }
        if scenario.after {
            #expect(output.page(at: scenario.pages - 1)?.string?.contains("Text after external document") == true)
        }
        for documentIndex in 0..<scenario.documents {
            for pageIndex in 0..<50 {
                let sourcePage = try #require(source.page(at: pageIndex))
                let outputPage = try #require(output.page(at: externalStart + documentIndex * 50 + pageIndex))
                let sourceText = try #require(sourcePage.string)
                #expect(!sourceText.isEmpty)
                #expect(outputPage.string == sourceText, "External document \(documentIndex), page \(pageIndex)")
            }
        }
    }

    @Test(arguments: [[1], [50], [50, 1, 25], [2, 2]], [false, true])
    func selectedExternalPagesPreserveRequestedOrderAndDuplicates(pages: [Int], debug: Bool) throws {
        // Arrange
        let url = try #require(Bundle.module.url(forResource: "50-pages", withExtension: "pdf"))
        let sourceDocument = PDFKit.PDFDocument(url: url)
        let source = try #require(sourceDocument)
        let document = TPPDF.PDFDocument(format: .a4)
        document.add(externalDocument: .init(url: url, pages: pages))
        let generator = PDFGenerator(document: document)
        generator.debug = debug

        // Act
        let data = try generator.generateData()
        let outputDocument = PDFKit.PDFDocument(data: data)
        let output = try #require(outputDocument)

        // Assert
        try #require(output.pageCount == pages.count)
        #expect(generator.totalPages == pages.count)
        for (index, sourceIndex) in pages.enumerated() {
            let sourcePage = try #require(source.page(at: sourceIndex - 1))
            let outputPage = try #require(output.page(at: index))
            let sourceText = try #require(sourcePage.string)
            #expect(!sourceText.isEmpty)
            #expect(outputPage.string == sourceText)
        }
    }

    @Test(arguments: [-1, 0, 51])
    func outOfBoundsExternalPageThrowsItsRequestedIndex(index: Int) throws {
        // Arrange
        let url = try #require(Bundle.module.url(forResource: "50-pages", withExtension: "pdf"))
        let document = TPPDF.PDFDocument(format: .a4)
        document.add(externalDocument: .init(url: url, pages: [index]))
        let generator = PDFGenerator(document: document)

        // Act
        let error = #expect(throws: PDFError.self) {
            try generator.generateData()
        }

        // Assert
        guard case let .pageOutOfBounds(actualIndex)? = error else {
            Issue.record("Expected pageOutOfBounds, got \(String(describing: error))")
            return
        }
        #expect(actualIndex == index)
    }

    @Test func missingExternalDocumentThrowsItsURL() {
        // Arrange
        let url = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString + ".pdf")
        let document = TPPDF.PDFDocument(format: .a4)
        document.add(externalDocument: .init(url: url))
        let generator = PDFGenerator(document: document)

        // Act
        let error = #expect(throws: PDFError.self) {
            try generator.generateData()
        }

        // Assert
        guard case let .externalDocumentURLInvalid(actualURL)? = error else {
            Issue.record("Expected externalDocumentURLInvalid, got \(String(describing: error))")
            return
        }
        #expect(actualURL == url)
    }
}
#endif
