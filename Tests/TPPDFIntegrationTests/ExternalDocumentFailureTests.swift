//
//  ExternalDocumentFailureTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.10.2026.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Foundation
import Testing
@testable import TPPDF

#if canImport(PDFKit)
import PDFKit

struct ExternalDocumentFailureTests {
    @Test(arguments: ["Not a PDF", "%PDF-1.7\n"])
    func invalidExternalFileThrowsAndCanBeReplacedForAFreshGeneration(invalidContent: String) throws {
        // Arrange
        let url = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString + ".pdf")
        defer { try? FileManager.default.removeItem(at: url) }
        try Data(invalidContent.utf8).write(to: url)
        let document = TPPDF.PDFDocument(format: .a4)
        document.add(text: "BEFORE")
        document.add(externalDocument: .init(url: url))
        let failedGenerator = PDFGenerator(document: document)

        // Act
        let error = #expect(throws: PDFError.self) {
            try failedGenerator.generateData()
        }
        let replacement = TPPDF.PDFDocument(format: .a4)
        replacement.add(text: "RECOVERED")
        let replacementData = try PDFGenerator(document: replacement).generateData()
        try replacementData.write(to: url)
        let data = try PDFGenerator(document: document).generateData()
        let outputDocument = PDFKit.PDFDocument(data: data)
        let output = try #require(outputDocument)

        // Assert
        guard case let .externalDocumentURLInvalid(actualURL)? = error else {
            Issue.record("Expected externalDocumentURLInvalid, got \(String(describing: error))")
            return
        }
        #expect(actualURL == url)
        #expect(output.pageCount == 2)
        #expect(output.page(at: 0)?.string?.contains("BEFORE") == true)
        #expect(output.page(at: 1)?.string?.contains("RECOVERED") == true)
    }

    #if os(macOS) && swift(>=6.2)
    @Test func lockedExternalDocumentReturnsAnErrorWithoutTerminatingProcess() async {
        // Arrange
        let expectedExit = ExitTest.Condition.success

        // Act
        let result = await #expect(processExitsWith: expectedExit) {
            let source = TPPDF.PDFDocument(format: .a4)
            source.info = PDFInfo(ownerPassword: "fixture-owner", userPassword: "fixture-reader")
            source.add(text: "LOCKED")
            let url = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString + ".pdf")
            defer { try? FileManager.default.removeItem(at: url) }
            try PDFGenerator(document: source).generate(to: url)
            let cgPDF = try #require(CGPDFDocument(url as CFURL))
            #expect(cgPDF.isEncrypted)
            #expect(!cgPDF.isUnlocked)
            let document = TPPDF.PDFDocument(format: .a4)
            document.add(externalDocument: .init(url: url))
            let error = #expect(throws: PDFError.self) {
                try PDFGenerator(document: document).generateData()
            }
            guard case let .pageOutOfBounds(index)? = error else {
                Issue.record("Expected pageOutOfBounds for inaccessible content, got \(String(describing: error))")
                return
            }
            #expect(index == 1)
        }

        // Assert
        #expect(result != nil)
    }
    #endif
}
#endif
