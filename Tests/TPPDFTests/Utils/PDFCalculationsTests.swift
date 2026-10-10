//
//  PDFCalculationsTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.02.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Foundation
import Testing
@testable import TPPDF

struct PDFCalculationsTests {
    @Test(arguments: [
        (CGSize(width: 100, height: 100), "12345\n12345\n12345\n12345\n12345", 33.369140625, 75.0, nil as String?),
        (CGSize(width: 10, height: 200), "12345\n12345\n123", 6.673828125, 195.0, "45\n12345\n12345"),
        (CGSize(width: 200, height: 20), "12345\n", 33.369140625, 15.0, "12345\n12345\n12345\n12345"),
        (CGSize(width: 20, height: 20), "12", 13.34765625, 15.0, "345\n12345\n12345\n12345\n12345"),
    ])
    func calculatesTextFrameAndRemainder(
        bounds: CGSize, expectedText: String, expectedWidth: Double, expectedHeight: Double, expectedRemainder: String?
    ) {
        // Arrange
        let text = NSAttributedString(string: "12345\n12345\n12345\n12345\n12345")
        let remainder = expectedRemainder.map { NSAttributedString(string: $0) }

        // Act
        let result = PDFCalculations.calculateTextSizeAndRemainder(of: text, in: bounds)

        // Assert
        #expect(result.text == NSAttributedString(string: expectedText))
        #expect(abs(result.size.width - expectedWidth) < 0.00001)
        #expect(result.size.height == CGFloat(expectedHeight))
        #expect(result.remainder == remainder)
    }
}
