//
//  PDFImageEquatableTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.12.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Foundation
import Testing
@testable import TPPDF

struct PDFImageEquatableTests {
    @Test func imagesWithSameSettingsAreEqual() throws {
        // Arrange
        let url = try #require(Bundle.module.url(forResource: "image-fixture", withExtension: "jpg"))
        let image = try #require(Image(data: Data(contentsOf: url)))
        let caption = PDFSimpleText(text: "EXAMPLE")
        let size = CGSize(width: 100, height: 100)
        let pdfImage = PDFImage(image: image, caption: caption, size: size, sizeFit: .height, quality: 0.9)
        let otherImage = PDFImage(image: image, caption: caption, size: size, sizeFit: .height, quality: 0.9)

        // Act
        let isEqual = pdfImage == otherImage

        // Assert
        #expect(isEqual)
    }

    @Test(arguments: ["image", "caption", "missingCaption", "size", "sizeFit", "quality"])
    func imagesWithDifferentSettingsAreUnequal(property: String) throws {
        // Arrange
        let url = try #require(Bundle.module.url(forResource: "image-fixture", withExtension: "jpg"))
        let image = try #require(Image(data: Data(contentsOf: url)))
        let caption = PDFSimpleText(text: "EXAMPLE")
        let size = CGSize(width: 100, height: 100)
        let pdfImage = PDFImage(image: image, caption: caption, size: size, sizeFit: .height, quality: 0.9)
        let otherImage = PDFImage(image: image, caption: caption, size: size, sizeFit: .height, quality: 0.9)
        switch property {
        case "image": otherImage.image = Image()
        case "caption": otherImage.caption = PDFSimpleText(text: "DIFFERENT")
        case "missingCaption": otherImage.caption = nil
        case "size": otherImage.size = CGSize(width: 20, height: 30)
        case "sizeFit": otherImage.sizeFit = .width
        default: otherImage.quality = 0.3
        }

        // Act
        let isEqual = pdfImage == otherImage

        // Assert
        #expect(!isEqual)
    }
}
