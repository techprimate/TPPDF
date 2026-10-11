//
//  PDFImageObjectTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09.10.2026.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Testing
@testable import TPPDF

struct PDFImageObjectTests {
    @Test(arguments: [0, 1, 2], [PDFImageOptions.none, [], .compress])
    func imagesWithoutResizingMoveToNextPage(alignmentIndex: Int, options: PDFImageOptions) throws {
        // Arrange
        let container: PDFContainer = [.contentLeft, .contentCenter, .contentRight][alignmentIndex]
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        let availableHeight = PDFCalculations.calculateAvailableFrameHeight(for: generator, in: container)
        _ = try PDFSpaceObject(space: availableHeight - 60).calculate(generator: generator, container: container)
        let image = PDFImageObject(image: PDFImage(image: Image(), size: CGSize(width: 180, height: 180), options: options))

        // Act
        let result = try image.calculate(generator: generator, container: container)

        // Assert
        try #require(result.count == 2)
        #expect(result[0].1 is PDFPageBreakObject)
        #expect(result[1].1 === image)
        #expect(image.frame.size == CGSize(width: 180, height: 180))
        #expect(image.frame.minY == generator.layout.margin.top)
        #expect(generator.layout.heights.content == 180)
    }

    @Test func resizingEnabledStillFitsRemainingPageHeight() throws {
        // Arrange
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        let availableHeight = PDFCalculations.calculateAvailableFrameHeight(for: generator, in: .contentRight)
        _ = try PDFSpaceObject(space: availableHeight - 60).calculate(generator: generator, container: .contentRight)
        let image = PDFImageObject(image: PDFImage(image: Image(), size: CGSize(width: 180, height: 180), options: [.resize]))

        // Act
        let result = try image.calculate(generator: generator, container: .contentRight)

        // Assert
        #expect(result.count == 1)
        #expect(image.frame.size == CGSize(width: 60, height: 60))
    }

    @Test(arguments: [0, 1, 2], [CGFloat(-1), 0, 1])
    func fixedImageBreaksOnlyWhenTallerThanRemainingSpace(alignmentIndex: Int, extraSpace: CGFloat) throws {
        // Arrange
        let container: PDFContainer = [.contentLeft, .contentCenter, .contentRight][alignmentIndex]
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        let availableHeight = PDFCalculations.calculateAvailableFrameHeight(for: generator, in: container)
        let precedingHeight = availableHeight - 180 - extraSpace
        _ = try PDFSpaceObject(space: precedingHeight).calculate(generator: generator, container: container)
        let image = PDFImageObject(image: PDFImage(image: Image(), size: CGSize(width: 180, height: 180), options: .none))
        let shouldBreak = extraSpace < 0

        // Act
        let result = try image.calculate(generator: generator, container: container)

        // Assert
        try #require(result.count == (shouldBreak ? 2 : 1))
        #expect(result.contains { $0.1 is PDFPageBreakObject } == shouldBreak)
        #expect(result.last?.1 === image)
        #expect(result.allSatisfy { $0.0 == container })
        #expect(image.frame.size == CGSize(width: 180, height: 180))
        #expect(image.frame.minY == generator.layout.margin.top + (shouldBreak ? 0 : precedingHeight))
        #expect(generator.layout.heights.content == (shouldBreak ? 180 : precedingHeight + 180))
    }

    @Test func widthConstrainedImageDoesNotAddUnnecessaryPageBreak() throws {
        // Arrange
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        let availableWidth = PDFCalculations.calculateAvailableFrameWidth(for: generator, in: .contentLeft)
        generator.layout.indentation.setRight(indentation: availableWidth - 60, in: .contentLeft)
        let availableHeight = PDFCalculations.calculateAvailableFrameHeight(for: generator, in: .contentLeft)
        _ = try PDFSpaceObject(space: availableHeight - 100).calculate(generator: generator, container: .contentLeft)
        let image = PDFImageObject(image: PDFImage(image: Image(), size: CGSize(width: 180, height: 180), options: .none))

        // Act
        let result = try image.calculate(generator: generator, container: .contentLeft)

        // Assert
        #expect(result.count == 1)
        #expect(image.frame.size == CGSize(width: 60, height: 60))
    }

    @Test func oversizedImageOnEmptyPageDoesNotAddBlankPage() throws {
        // Arrange
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        let availableHeight = PDFCalculations.calculateAvailableFrameHeight(for: generator, in: .contentLeft)
        let image = PDFImageObject(image: PDFImage(
            image: Image(), size: CGSize(width: 180, height: availableHeight * 2), options: .none
        ))

        // Act
        let result = try image.calculate(generator: generator, container: .contentLeft)

        // Assert
        #expect(result.count == 1)
        #expect(image.frame.height == availableHeight)
    }
}
