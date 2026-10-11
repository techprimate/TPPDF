//
//  PDFPageBreakObjectTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.14.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Foundation
import Testing
@testable import TPPDF

struct PDFPageBreakObjectTests {
    @Test func calculatingPageBreakResetsContentHeightAndReturnsObject() throws {
        // Arrange
        let object = PDFPageBreakObject()
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        let container = PDFContainer.contentLeft

        // Act
        let result = try object.calculate(generator: generator, container: container)

        // Assert
        #expect(generator.layout.heights.content == 0)
        #expect(result.count == 1)
        #expect(result.first?.0 == container)
        #expect(result.first?.1 as? PDFPageBreakObject == object)
    }

    @Test func drawingPageBreakDoesNotThrow() throws {
        // Arrange
        let object = PDFPageBreakObject()
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        let url = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(UUID().uuidString)
        defer { try? FileManager.default.removeItem(at: url) }
        let context = try #require(CGContext(url as CFURL, mediaBox: nil, nil))

        // Act and Assert
        #expect(throws: Never.self) {
            try object.draw(generator: generator, container: .contentLeft, in: PDFContext(cgContext: context))
        }
    }
}
