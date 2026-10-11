//
//  PDFSimpleTextEquatableTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.14.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Testing
@testable import TPPDF

struct PDFSimpleTextEquatableTests {
    @Test(arguments: [("EXAMPLE", 0.0, true), ("DIFFERENT", 0.0, false), ("EXAMPLE", 20.0, false)])
    func equalityDependsOnContentAndSpacing(content: String, spacing: Double, expectedEquality: Bool) {
        // Arrange
        let text = PDFSimpleText(text: "EXAMPLE")
        let otherText = PDFSimpleText(text: content, spacing: CGFloat(spacing))

        // Act
        let isEqual = text == otherText

        // Assert
        #expect(isEqual == expectedEquality)
    }
}
