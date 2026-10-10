//
//  PDFListItemSymbolTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 05.12.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Testing
@testable import TPPDF

struct PDFListItemSymbolTests {
    @Test(arguments: [
        (0, "", "none"), (1, "", "inherit"), (2, "\u{00B7}", "dot"),
        (3, "-", "dash"), (4, "%@", "custom|%@"), (5, "%@.", "numbered|%@"),
    ])
    func symbolsProvideExpectedDisplayTextAndRawValues(index: Int, expectedText: String, expectedRawValue: String) {
        // Arrange
        let symbols: [PDFListItemSymbol] = [.none, .inherit, .dot, .dash, .custom(value: "%@"), .numbered(value: "%@")]
        let symbol = symbols[index]

        // Act
        let text = symbol.stringValue
        let rawValue = symbol.rawValue

        // Assert
        #expect(text == expectedText)
        #expect(rawValue == expectedRawValue)
    }

    @Test func numberedSymbolWithoutTemplateHasNilRawValueSuffix() {
        // Arrange
        let symbol = PDFListItemSymbol.numbered(value: nil)

        // Act
        let rawValue = symbol.rawValue

        // Assert
        #expect(rawValue == "numbered|nil")
    }

    @Test func rawValueTypeIsString() {
        // Arrange
        let rawValueType = PDFListItemSymbol.RawValue.self

        // Act
        let isString = rawValueType == String.self

        // Assert
        #expect(isString)
    }

    @Test(arguments: [
        ("none", "none"), ("inherit", "inherit"), ("dot", "dot"), ("dash", "dash"),
        ("", "none"), ("|", "none"), ("||", "none"), ("asdf|", "none"),
        ("custom|", "custom|"), ("custom|%@", "custom|%@"),
        ("numbered|", "numbered|"), ("numbered|nil", "numbered|nil"), ("numbered|%@", "numbered|%@"),
    ])
    func initializingFromRawValuePreservesRecognizedValuesAndFallsBackForUnknownValues(rawValue: String, expectedValue: String) {
        // Arrange
        let input = rawValue

        // Act
        let symbol = PDFListItemSymbol(rawValue: input)

        // Assert
        #expect(symbol?.rawValue == expectedValue)
    }
}
