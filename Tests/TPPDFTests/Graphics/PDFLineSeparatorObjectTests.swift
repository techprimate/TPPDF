//
//  PDFLineSeparatorObjectTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.12.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Testing
@testable import TPPDF

struct PDFLineSeparatorObjectTests {
    @Test func initializingWithoutArgumentsUsesDefaultLineStyle() {
        // Arrange
        let expectedStyle = PDFLineStyle()

        // Act
        let separator = PDFLineSeparatorObject()

        // Assert
        #expect(separator.style == expectedStyle)
    }

    @Test func initializingWithStylePreservesStyle() {
        // Arrange
        let style = PDFLineStyle(type: .dotted, color: .orange, width: 0.25)

        // Act
        let separator = PDFLineSeparatorObject(style: style)

        // Assert
        #expect(separator.style == style)
    }

    @Test func calculatingInLeftHeaderPositionsSeparatorAcrossAvailableWidth() throws {
        // Arrange
        let separator = PDFLineSeparatorObject()
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        let container = PDFContainer.headerLeft

        // Act
        let result = try separator.calculate(generator: generator, container: container)

        // Assert
        #expect(result.first?.0 == container)
        #expect(result.first?.1 as? PDFLineSeparatorObject === separator)
        #expect(separator.frame == CGRect(x: 60, y: 60, width: 475, height: separator.style.width))
    }
}
