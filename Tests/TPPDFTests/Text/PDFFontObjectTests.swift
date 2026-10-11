//
//  PDFFontObjectTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 06.12.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Testing
@testable import TPPDF

struct PDFFontObjectTests {
    @Test func initializingWithFontPreservesFont() {
        // Arrange
        let font = Font.boldSystemFont(ofSize: 100)

        // Act
        let object = PDFFontObject(font: font)

        // Assert
        #expect(object.font == font)
    }

    @Test func calculatingSetsContainerFontAndReturnsUnpositionedObject() throws {
        // Arrange
        let font = Font.boldSystemFont(ofSize: 100)
        let object = PDFFontObject(font: font)
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        let container = PDFContainer.contentLeft

        // Act
        let result = try object.calculate(generator: generator, container: container)

        // Assert
        #expect(generator.fonts[container] == font)
        #expect(object.frame == CGRect.null)
        #expect(result.count == 1)
        #expect(result.first?.0 == container)
        #expect(result.first?.1 as? PDFFontObject === object)
    }
}
