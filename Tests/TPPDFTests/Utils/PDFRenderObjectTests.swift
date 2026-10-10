//
//  PDFRenderObjectTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.02.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Foundation
import Testing
@testable import TPPDF

struct PDFRenderObjectTests {
    @Test func initializesWithNullFrame() {
        // Arrange
        let expectedFrame = CGRect.null

        // Act
        let object = PDFRenderObject()

        // Assert
        #expect(object.frame == expectedFrame)
    }

    @Test func calculatingReturnsNoSubobjects() throws {
        // Arrange
        let object = PDFRenderObject()
        let generator = PDFGenerator(document: PDFDocument(format: .a4))

        // Act
        let objects = try object.calculate(generator: generator, container: .none)

        // Assert
        #expect(objects.isEmpty)
    }

    @Test func drawingDoesNotThrow() throws {
        // Arrange
        let object = PDFRenderObject()
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        let url = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(UUID().uuidString)
        defer { try? FileManager.default.removeItem(at: url) }
        let context = try #require(CGContext(url as CFURL, mediaBox: nil, nil))

        // Act
        try object.draw(generator: generator, container: .none, in: PDFContext(cgContext: context))

        // Assert
        #expect(object.frame == CGRect.null)
    }
}
