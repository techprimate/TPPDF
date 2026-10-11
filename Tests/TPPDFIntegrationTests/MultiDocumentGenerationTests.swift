//
//  MultiDocumentGenerationTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.10.2026.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Foundation
import Testing
@testable import TPPDF

#if canImport(PDFKit)
import PDFKit

struct MultiDocumentGenerationTests {
    @Test(arguments: [false, true], [false, true])
    func generationPreservesDocumentOrderAndUsesExplicitOrFirstDocumentMetadata(writeFile: Bool, overrideInfo: Bool) throws {
        // Arrange
        let first = TPPDF.PDFDocument(format: .a4)
        first.info = PDFInfo(title: "First title", author: "First author", subject: "First subject")
        first.add(text: "FIRST DOCUMENT")
        let second = TPPDF.PDFDocument(format: .a4)
        second.info = PDFInfo(title: "Second title", author: "Second author", subject: "Second subject")
        second.add(text: "SECOND DOCUMENT")
        let generator = PDFMultiDocumentGenerator(documents: [first, second])
        let info = overrideInfo ? PDFInfo(title: "Override title", author: "Override author", subject: "Override subject") : nil
        let url = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString + ".pdf")
        defer { if writeFile { try? FileManager.default.removeItem(at: url) } }

        // Act
        let data: Data
        if writeFile {
            try generator.generate(to: url, info: info)
            data = try Data(contentsOf: url)
        } else {
            data = try generator.generateData(info: info)
        }
        let outputDocument = PDFKit.PDFDocument(data: data)
        let output = try #require(outputDocument)

        // Assert
        try #require(output.pageCount == 2)
        #expect(output.page(at: 0)?.string?.contains("FIRST DOCUMENT") == true)
        #expect(output.page(at: 1)?.string?.contains("SECOND DOCUMENT") == true)
        let metadata = try #require(output.documentAttributes)
        #expect(metadata[PDFDocumentAttribute.titleAttribute] as? String == (overrideInfo ? "Override title" : "First title"))
        #expect(metadata[PDFDocumentAttribute.authorAttribute] as? String == (overrideInfo ? "Override author" : "First author"))
        #expect(metadata[PDFDocumentAttribute.subjectAttribute] as? String == (overrideInfo ? "Override subject" : "First subject"))
    }
}
#endif
