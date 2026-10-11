//
//  PDFAttributedTextTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.05.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Foundation
import Testing
@testable import TPPDF

struct PDFAttributedTextTests {
    @Test func initializingWithAttributedStringPreservesText() {
        // Arrange
        let text = NSAttributedString(string: "example")

        // Act
        let object = PDFAttributedText(text: text)

        // Assert
        #expect(object.text == text)
    }
}
