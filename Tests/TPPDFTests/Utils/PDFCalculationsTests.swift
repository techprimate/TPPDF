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

    @Test(arguments: [
        (bounds: CGSize(width: 1000, height: 1000), rendersText: true, hasRemainder: false),
        (bounds: CGSize(width: 100, height: 20), rendersText: true, hasRemainder: true),
        (bounds: CGSize(width: 100, height: 1), rendersText: false, hasRemainder: true),
    ])
    func splittingPreservesDistinctUnicodeTextAndAttributes(
        scenario: (bounds: CGSize, rendersText: Bool, hasRemainder: Bool)
    ) {
        // Arrange
        let text = NSMutableAttributedString(string: "FIRST café e\u{301} 👩🏽‍💻\nSECOND Ω\nTHIRD 終",
                                             attributes: [.font: Font.systemFont(ofSize: 12)])
        text.addAttribute(.foregroundColor, value: Color.red, range: NSRange(location: 0, length: 5))
        let original = NSAttributedString(attributedString: text)

        // Act
        let result = PDFCalculations.calculateTextSizeAndRemainder(of: text, in: scenario.bounds)
        let reconstructed = NSMutableAttributedString(attributedString: result.text)
        if let remainder = result.remainder { reconstructed.append(remainder) }

        // Assert
        #expect((result.text.length > 0) == scenario.rendersText)
        #expect((result.remainder != nil) == scenario.hasRemainder)
        #expect(reconstructed == original)
        #expect(text == original)
    }

    @Test(arguments: [CGFloat(0), -1])
    func noRemainingHeightDefersAllTextWithoutRendering(height: CGFloat) {
        // Arrange
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        let availableHeight = PDFCalculations.calculateAvailableFrameHeight(for: generator, in: .contentLeft)
        generator.layout.heights.content = availableHeight - height
        let text = NSAttributedString(string: "Deferred text")

        // Act
        let result = PDFCalculations.calculateText(generator: generator, container: .contentLeft, text: text)

        // Assert
        #expect(result.frame == .zero)
        #expect(result.render == nil)
        #expect(result.remainder == text)
    }
}
