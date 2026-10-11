//
//  PDFTextColorObjectTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 05.12.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Testing
@testable import TPPDF

struct PDFTextColorObjectTests {
    @Test func initializingWithColorPreservesColor() {
        // Arrange
        let color = Color.red

        // Act
        let object = PDFTextColorObject(color: color)

        // Assert
        #expect(object.color == color)
    }

    @Test func calculatingSetsContainerColorAndReturnsUnpositionedObject() throws {
        // Arrange
        let color = Color.red
        let object = PDFTextColorObject(color: color)
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        let container = PDFContainer.contentLeft

        // Act
        let result = try object.calculate(generator: generator, container: container)

        // Assert
        #expect(generator.textColor[container] == color)
        #expect(object.frame == CGRect.null)
        #expect(result.count == 1)
        #expect(result.first?.0 == container)
        #expect(result.first?.1 as? PDFTextColorObject === object)
    }
}
