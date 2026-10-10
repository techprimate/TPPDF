//
//  PDFGraphicsTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.02.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Foundation
import Testing
@testable import TPPDF

struct PDFGraphicsTests {
    @Test func dashedLinesUseButtCapsAndLengthsProportionalToWidth() throws {
        // Arrange
        let style = PDFLineStyle(type: .dashed, color: .red, width: 5)

        // Act
        let dashes = try #require(PDFGraphics.createDashes(style: style))

        // Assert
        #expect(dashes.lengths == [15, 15])
        #expect(dashes.cap == .butt)
    }

    @Test func dottedLinesUseRoundCapsAndLengthsProportionalToWidth() throws {
        // Arrange
        let style = PDFLineStyle(type: .dotted, color: .red, width: 5)

        // Act
        let dashes = try #require(PDFGraphics.createDashes(style: style))

        // Assert
        #expect(dashes.lengths == [0, 10])
        #expect(dashes.cap == .round)
    }

    @Test func linesWithoutDashesDoNotCreateDashPattern() {
        // Arrange
        let style = PDFLineStyle(type: .none, color: .red, width: 5)

        // Act
        let dashes = PDFGraphics.createDashes(style: style)

        // Assert
        #expect(dashes == nil)
    }

    @Test func resizingWithoutCompressionCreatesImageAtRequestedQuality() throws {
        // Arrange
        let image = try loadImage()
        let frame = CGRect(x: 0, y: 0, width: 40, height: 40)

        // Act
        let result = PDFGraphics.resizeAndCompressImage(
            image: image, frame: frame, shouldResize: true, shouldCompress: false, quality: 0.2
        )

        // Assert
        #expect(image.size == CGSize(width: 61, height: 68))
        #expect(result !== image)
        #expect(abs(result.size.width - 24) < 0.0001)
        #expect(abs(result.size.height - 24) < 0.0001)
    }

    @Test func compressingWithoutResizingPreservesImageSize() throws {
        // Arrange
        let image = try loadImage()
        let frame = CGRect(x: 0, y: 0, width: 40, height: 40)

        // Act
        let result = PDFGraphics.resizeAndCompressImage(
            image: image, frame: frame, shouldResize: false, shouldCompress: true, quality: 0.2
        )

        // Assert
        #expect(image.size == CGSize(width: 61, height: 68))
        #expect(result !== image)
        #expect(result.size == image.size)
    }

    @Test(arguments: [(0.2, 24.0), (0.0, 8.0)])
    func resizingAndCompressingUsesQualityToDetermineSize(quality: Double, expectedLength: Double) throws {
        // Arrange
        let image = try loadImage()
        let frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        let expectedSize = CGSize(width: expectedLength, height: expectedLength)

        // Act
        let result = PDFGraphics.resizeAndCompressImage(
            image: image, frame: frame, shouldResize: true, shouldCompress: true, quality: CGFloat(quality)
        )

        // Assert
        #expect(image.size == CGSize(width: 61, height: 68))
        #expect(result !== image)
        #expect(result.size == expectedSize)
    }

    @Test func disablingResizingAndCompressionReturnsOriginalImage() throws {
        // Arrange
        let image = try loadImage()
        let frame = CGRect(x: 0, y: 0, width: 40, height: 40)

        // Act
        let result = PDFGraphics.resizeAndCompressImage(
            image: image, frame: frame, shouldResize: false, shouldCompress: false, quality: 0.2
        )

        // Assert
        #expect(image.size == CGSize(width: 61, height: 68))
        #expect(result === image)
    }

    @Test func roundingCornersCreatesNewImageWithoutResizingOrCompression() throws {
        // Arrange
        let image = try loadImage()
        let frame = CGRect(x: 0, y: 0, width: 40, height: 40)

        // Act
        let result = PDFGraphics.resizeAndCompressImage(
            image: image, frame: frame, shouldResize: false, shouldCompress: false, quality: 0,
            roundCorners: [.allCorners], cornerRadius: 10
        )

        // Assert
        #expect(image.size == CGSize(width: 61, height: 68))
        #expect(result !== image)
    }

    private func loadImage() throws -> Image {
        let url = try #require(Bundle.module.url(forResource: "graphics-fixture", withExtension: "gif"))
        return try #require(Image(data: Data(contentsOf: url)))
    }
}
