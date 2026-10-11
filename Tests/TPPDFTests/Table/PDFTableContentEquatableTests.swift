//
//  PDFTableContentEquatableTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.16.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Foundation
import Testing
@testable import TPPDF

struct PDFTableContentEquatableTests {
    @Test(arguments: ["same", "type", "string", "attributedString", "unknownObjects"])
    func equalityDependsOnRecognizedTypeAndContentButIgnoresUnknownObjects(kind: String) {
        // Arrange
        let content = PDFTableContent(type: .none, content: nil)
        let otherContent: PDFTableContent
        switch kind {
        case "type": otherContent = PDFTableContent(type: .string, content: nil)
        case "string":
            content.type = .string
            content.content = "EXAMPLE"
            otherContent = PDFTableContent(type: .string, content: "INVALID")
        case "attributedString":
            content.type = .attributedString
            content.content = NSAttributedString(string: "EXAMPLE")
            otherContent = PDFTableContent(type: .attributedString, content: NSAttributedString(string: "INVALID"))
        case "unknownObjects":
            content.type = .image
            content.content = ["RANDOM"]
            otherContent = PDFTableContent(type: .image, content: ["RANDOM"])
        default: otherContent = PDFTableContent(type: .none, content: nil)
        }

        // Act
        let isEqual = content == otherContent

        // Assert
        #expect(isEqual == (kind == "same" || kind == "unknownObjects"))
    }

    @Test func differentImagesMakeContentUnequal() throws {
        // Arrange
        let url = try #require(Bundle.module.url(forResource: "table-content-fixture", withExtension: "png"))
        let image = try #require(Image(data: Data(contentsOf: url)))
        let content = PDFTableContent(type: .image, content: Image())
        let otherContent = PDFTableContent(type: .image, content: image)

        // Act
        let isEqual = content == otherContent

        // Assert
        #expect(!isEqual)
    }

    @Test(arguments: [false, true])
    func missingImageContentOnEitherSideMakesContentUnequal(missingOnLeft: Bool) {
        // Arrange
        let image = Image()
        let content = PDFTableContent(type: .image, content: missingOnLeft ? nil : image)
        let otherContent = PDFTableContent(type: .image, content: missingOnLeft ? image : nil)

        // Act
        let isEqual = content == otherContent

        // Assert
        #expect(!isEqual)
    }
}
