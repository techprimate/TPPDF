//
//  PDFAttributedTextEquatableTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.14.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Foundation
import Testing
@testable import TPPDF

struct PDFAttributedTextEquatableTests {
    @Test(arguments: [("EXAMPLE", true), ("INVALID", false)])
    func equalityDependsOnAttributedContent(content: String, expectedEquality: Bool) {
        // Arrange
        let text = PDFAttributedText(text: NSAttributedString(string: "EXAMPLE"))
        let otherText = PDFAttributedText(text: NSAttributedString(string: content))

        // Act
        let isEqual = text == otherText

        // Assert
        #expect(isEqual == expectedEquality)
    }
}
