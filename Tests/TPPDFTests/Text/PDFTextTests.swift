//
//  PDFTextTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 05.12.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Foundation
import Testing
@testable import TPPDF

struct PDFTextTests {
    @Test(arguments: [false, true])
    func matchingTextOfSameSubclassIsEqual(attributed: Bool) {
        // Arrange
        let text: PDFText = attributed
            ? PDFAttributedText(text: NSAttributedString(string: "EXAMPLE"))
            : PDFSimpleText(text: "EXAMPLE")
        let otherText: PDFText = attributed
            ? PDFAttributedText(text: NSAttributedString(string: "EXAMPLE"))
            : PDFSimpleText(text: "EXAMPLE")

        // Act
        let isEqual = text == otherText
        let isUnequal = text != otherText

        // Assert
        #expect(isEqual)
        #expect(!isUnequal)
    }

    @Test func matchingContentInDifferentTextSubclassesIsUnequal() {
        // Arrange
        let text: PDFText = PDFSimpleText(text: "EXAMPLE")
        let otherText: PDFText = PDFAttributedText(text: NSAttributedString(string: "EXAMPLE"))

        // Act
        let isEqual = text == otherText

        // Assert
        #expect(!isEqual)
    }
}
