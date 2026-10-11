//
//  PDFAttributedTextObjectTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.05.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Foundation
import Testing
@testable import TPPDF

struct PDFAttributedTextObjectTests {
    @Test func initializingWithSimpleTextStoresOnlySimpleText() {
        // Arrange
        let text = PDFSimpleText(text: "example")

        // Act
        let object = PDFAttributedTextObject(text: text)

        // Assert
        #expect(object.simpleText != nil)
        #expect(object.attributedText == nil)
    }

    @Test func initializingWithAttributedTextStoresOnlyAttributedText() {
        // Arrange
        let text = PDFAttributedText(text: NSAttributedString(string: "example"))

        // Act
        let object = PDFAttributedTextObject(text: text)

        // Assert
        #expect(object.simpleText == nil)
        #expect(object.attributedText != nil)
    }

    #if os(macOS) && swift(>=6.2)
    @Test func initializingWithUnsupportedTextSubclassTerminatesProcess() async {
        // Arrange
        let expectedExit = ExitTest.Condition.failure

        // Act
        let result = await #expect(processExitsWith: expectedExit) {
            class CustomText: PDFText {}
            let text = CustomText()
            _ = PDFAttributedTextObject(text: text)
        }

        // Assert
        #expect(result != nil)
    }
    #endif
}
