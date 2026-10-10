//
//  PDFLineSeparatorObjectEquatableTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.12.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Testing
@testable import TPPDF

struct PDFLineSeparatorObjectEquatableTests {
    @Test func separatorsWithSameStyleAreEqual() {
        // Arrange
        let style = PDFLineStyle(type: .dotted, color: .orange, width: 0.25)
        let separator = PDFLineSeparatorObject(style: style)
        let otherSeparator = PDFLineSeparatorObject(style: style)

        // Act
        let isEqual = separator == otherSeparator

        // Assert
        #expect(isEqual)
    }

    @Test func separatorsWithDifferentStylesAreUnequal() {
        // Arrange
        let firstStyle = PDFLineStyle(type: .dotted, color: .orange, width: 0.25)
        let secondStyle = PDFLineStyle(type: .dashed, color: .blue, width: 1)
        let separator = PDFLineSeparatorObject(style: firstStyle)
        let otherSeparator = PDFLineSeparatorObject(style: secondStyle)

        // Act
        let isEqual = separator == otherSeparator

        // Assert
        #expect(!isEqual)
    }
}
