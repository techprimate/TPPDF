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
    func externalDocumentsPreservePageCountsWithSurroundingContentAndDebugMode(
        scenario: (before: Bool, after: Bool, documents: Int, pages: Int), debug: Bool
    ) throws {
        // Arrange
        let url = try #require(Bundle.module.url(forResource: "50-pages", withExtension: "pdf"))
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
        #expect(output.pageCount == scenario.pages)
    }
}
#endif
