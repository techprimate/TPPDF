//
//  PDFTableContentTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.16.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Foundation
import Testing
@testable import TPPDF

struct PDFTableContentTests {
    @Test func initializingWithNilUsesNoneTypeAndNoContent() throws {
        // Arrange
        let value: Any? = nil

        // Act
        let optionalContent = try PDFTableContent(content: value)

        // Assert
        let content = try #require(optionalContent)
        #expect(content.type == .none)
        #expect(content.content == nil)
    }

    @Test func initializingWithNumberAcceptsNumericContent() throws {
        // Arrange
        let value = 123

        // Act
        let content = try PDFTableContent(content: value)

        // Assert
        #expect(content != nil)
    }

    @Test func initializingWithUnsupportedContentThrows() {
        // Arrange
        let value = ["EXAMPLE"]

        // Act and Assert
        #expect(throws: (any Error).self) {
            try PDFTableContent(content: value)
        }
    }

    @Test func initializingWithExplicitTypePreservesAttributedContent() {
        // Arrange
        let text = NSAttributedString(string: "EXAMPLE")

        // Act
        let content = PDFTableContent(type: .attributedString, content: text)

        // Assert
        #expect(content.type == .attributedString)
        #expect(content.content as? NSAttributedString == text)
    }

    @Test func settingNilContentUsesNoneTypeAndNoValue() throws {
        // Arrange
        let optionalContent = try PDFTableContent(content: nil)
        let content = try #require(optionalContent)

        // Act
        try content.setContent(content: nil)

        // Assert
        #expect(content.type == .none)
        #expect(content.content == nil)
    }

    @Test(arguments: ["string", "image", "attributedString", "int", "double", "float"])
    func settingSupportedContentUpdatesTypeAndStoredValue(kind: String) throws {
        // Arrange
        let optionalContent = try PDFTableContent(content: nil)
        let content = try #require(optionalContent)
        let image = Image()
        let text = NSAttributedString(string: "EXAMPLE")
        let value: Any?
        let expectedType: PDFTableContent.ContentType
        let expectedString: String?
        switch kind {
        case "image": (value, expectedType, expectedString) = (image, .image, nil)
        case "attributedString": (value, expectedType, expectedString) = (text, .attributedString, nil)
        case "int": (value, expectedType, expectedString) = (123_456, .string, "123456")
        case "double": (value, expectedType, expectedString) = (Double(123.456), .string, "123.456")
        case "float": (value, expectedType, expectedString) = (Float(123.456), .string, "123.456")
        default: (value, expectedType, expectedString) = ("EXAMPLE", .string, "EXAMPLE")
        }

        // Act
        try content.setContent(content: value)

        // Assert
        #expect(content.type == expectedType)
        switch kind {
        case "image": #expect(content.content as? Image == image)
        case "attributedString": #expect(content.content as? NSAttributedString == text)
        default: #expect(content.content as? String == expectedString)
        }
    }

    @Test func settingUnsupportedContentThrows() throws {
        // Arrange
        let optionalContent = try PDFTableContent(content: nil)
        let content = try #require(optionalContent)
        let value = ["INVALID"]

        // Act and Assert
        #expect(throws: (any Error).self) {
            try content.setContent(content: value)
        }
    }

    @Test(arguments: 0..<4)
    func typePredicatesIdentifyOnlyMatchingContentType(index: Int) {
        // Arrange
        let types: [PDFTableContent.ContentType] = [.none, .string, .attributedString, .image]
        let content = PDFTableContent(type: .none, content: nil)
        content.type = types[index]

        // Act
        let isString = content.isString
        let isAttributedString = content.isAttributedString
        let isImage = content.isImage

        // Assert
        #expect(isString == (index == 1))
        #expect(isAttributedString == (index == 2))
        #expect(isImage == (index == 3))
    }

    @Test(arguments: 0..<4)
    func stringValueIsExposedOnlyWhenTypeIsString(index: Int) {
        // Arrange
        let types: [PDFTableContent.ContentType] = [.none, .string, .attributedString, .image]
        let content = PDFTableContent(type: .none, content: "EXAMPLE")
        content.type = types[index]

        // Act
        let value = content.stringValue

        // Assert
        #expect(value == (index == 1 ? "EXAMPLE" : nil))
    }

    @Test(arguments: 0..<4)
    func attributedStringValueIsExposedOnlyWhenTypeMatches(index: Int) {
        // Arrange
        let types: [PDFTableContent.ContentType] = [.none, .string, .attributedString, .image]
        let text = NSAttributedString(string: "EXAMPLE")
        let content = PDFTableContent(type: .none, content: text)
        content.type = types[index]

        // Act
        let value = content.attributedStringValue

        // Assert
        #expect(value == (index == 2 ? text : nil))
    }

    @Test(arguments: 0..<4)
    func imageValueIsExposedOnlyWhenTypeMatches(index: Int) {
        // Arrange
        let types: [PDFTableContent.ContentType] = [.none, .string, .attributedString, .image]
        let image = Image()
        let content = PDFTableContent(type: .none, content: image)
        content.type = types[index]

        // Act
        let value = content.imageValue

        // Assert
        #expect(value == (index == 3 ? image : nil))
    }

    @Test func stringExtensionProducesStringContent() {
        // Arrange
        let text = "EXAMPLE"

        // Act
        let content = text.asTableContent

        // Assert
        #expect(content.type == .string)
        #expect(content.content as? String == text)
    }

    @Test func attributedStringExtensionProducesAttributedContent() {
        // Arrange
        let text = NSAttributedString(string: "EXAMPLE")

        // Act
        let content = text.asTableContent

        // Assert
        #expect(content.type == .attributedString)
        #expect(content.content as? NSAttributedString == text)
    }

    @Test func imageExtensionPreservesImageIdentity() {
        // Arrange
        let image = Image()

        // Act
        let content = image.asTableContent

        // Assert
        #expect(content.type == .image)
        #expect(content.content as? Image === image)
    }
}
