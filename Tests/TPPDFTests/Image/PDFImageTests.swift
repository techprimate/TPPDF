//
//  PDFImageTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.12.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Foundation
import Testing
@testable import TPPDF

struct PDFImageTests {
    @Test func initializingWithOnlyImageUsesDefaultSettings() throws {
        // Arrange
        let url = try #require(Bundle.module.url(forResource: "image-fixture", withExtension: "jpg"))
        let image = try #require(Image(data: Data(contentsOf: url)))

        // Act
        let pdfImage = PDFImage(image: image)

        // Assert
        #expect(pdfImage.image == image)
        #expect(pdfImage.caption == nil)
        #expect(pdfImage.sizeFit == .widthHeight)
        #expect(pdfImage.quality == 0.85)
        #expect(pdfImage.options == [.resize, .compress])
    }

    @Test func initializingWithCustomSettingsPreservesAllValues() throws {
        // Arrange
        let url = try #require(Bundle.module.url(forResource: "image-fixture", withExtension: "jpg"))
        let image = try #require(Image(data: Data(contentsOf: url)))
        let caption = PDFSimpleText(text: "EXAMPLE")
        let size = CGSize(width: 100, height: 100)
        let fittingMode = PDFImageSizeFit.height
        let quality: CGFloat = 0.9
        let options: PDFImageOptions = [.resize]

        // Act
        let pdfImage = PDFImage(
            image: image, caption: caption, size: size, sizeFit: fittingMode, quality: quality, options: options
        )

        // Assert
        #expect(pdfImage.image == image)
        #expect(pdfImage.caption as? PDFSimpleText == caption)
        #expect(pdfImage.size == size)
        #expect(pdfImage.sizeFit == fittingMode)
        #expect(pdfImage.quality == quality)
        #expect(pdfImage.options == options)
    }
}
