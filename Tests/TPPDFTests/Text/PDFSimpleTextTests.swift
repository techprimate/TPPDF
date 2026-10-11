//
//  PDFSimpleTextTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.14.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Testing
@testable import TPPDF

struct PDFSimpleTextTests {
    @Test func initializingWithSpacingPreservesTextAndSpacing() {
        // Arrange
        let text = "EXAMPLE"
        let spacing: CGFloat = 10

        // Act
        let object = PDFSimpleText(text: text, spacing: spacing)

        // Assert
        #expect(object.text == text)
        #expect(object.spacing == spacing)
    }

    @Test func initializingWithoutSpacingUsesZeroSpacing() {
        // Arrange
        let text = "STRING"

        // Act
        let object = PDFSimpleText(text: text)

        // Assert
        #expect(object.text == text)
        #expect(object.spacing == 0)
    }
}
