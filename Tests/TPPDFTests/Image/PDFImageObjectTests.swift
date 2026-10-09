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
        let container: PDFContainer = [.contentLeft, .contentCenter, .contentRight][alignmentIndex]
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        let availableHeight = PDFCalculations.calculateAvailableFrameHeight(for: generator, in: container)
        _ = try PDFSpaceObject(space: availableHeight - 60).calculate(generator: generator, container: container)
        let image = PDFImageObject(image: PDFImage(image: Image(), size: CGSize(width: 180, height: 180), options: options))

        let result = try image.calculate(generator: generator, container: container)

        try #require(result.count == 2)
        #expect(result[0].1 is PDFPageBreakObject)
        #expect(result[1].1 === image)
        #expect(image.frame.size == CGSize(width: 180, height: 180))
        #expect(image.frame.minY == generator.layout.margin.top)
        #expect(generator.layout.heights.content == 180)
    }

    @Test func resizingEnabledStillFitsRemainingPageHeight() throws {
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        let availableHeight = PDFCalculations.calculateAvailableFrameHeight(for: generator, in: .contentRight)
        _ = try PDFSpaceObject(space: availableHeight - 60).calculate(generator: generator, container: .contentRight)
        let image = PDFImageObject(image: PDFImage(image: Image(), size: CGSize(width: 180, height: 180), options: [.resize]))

        let result = try image.calculate(generator: generator, container: .contentRight)

        #expect(result.count == 1)
        #expect(image.frame.size == CGSize(width: 60, height: 60))
    }

    @Test func fixedImageThatExactlyFitsDoesNotAddPageBreak() throws {
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        let availableHeight = PDFCalculations.calculateAvailableFrameHeight(for: generator, in: .contentRight)
        _ = try PDFSpaceObject(space: availableHeight - 180).calculate(generator: generator, container: .contentRight)
        let image = PDFImageObject(image: PDFImage(image: Image(), size: CGSize(width: 180, height: 180), options: .none))

        let result = try image.calculate(generator: generator, container: .contentRight)

        #expect(result.count == 1)
        #expect(image.frame.size == CGSize(width: 180, height: 180))
    }

    @Test func widthConstrainedImageDoesNotAddUnnecessaryPageBreak() throws {
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        let availableWidth = PDFCalculations.calculateAvailableFrameWidth(for: generator, in: .contentLeft)
        generator.layout.indentation.setRight(indentation: availableWidth - 60, in: .contentLeft)
        let availableHeight = PDFCalculations.calculateAvailableFrameHeight(for: generator, in: .contentLeft)
        _ = try PDFSpaceObject(space: availableHeight - 100).calculate(generator: generator, container: .contentLeft)
        let image = PDFImageObject(image: PDFImage(image: Image(), size: CGSize(width: 180, height: 180), options: .none))

        let result = try image.calculate(generator: generator, container: .contentLeft)

        #expect(result.count == 1)
        #expect(image.frame.size == CGSize(width: 60, height: 60))
    }

    @Test func oversizedImageOnEmptyPageDoesNotAddBlankPage() throws {
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        let availableHeight = PDFCalculations.calculateAvailableFrameHeight(for: generator, in: .contentLeft)
        let image = PDFImageObject(image: PDFImage(
            image: Image(), size: CGSize(width: 180, height: availableHeight * 2), options: .none
        ))

        let result = try image.calculate(generator: generator, container: .contentLeft)

        #expect(result.count == 1)
        #expect(image.frame.height == availableHeight)
    }
}
