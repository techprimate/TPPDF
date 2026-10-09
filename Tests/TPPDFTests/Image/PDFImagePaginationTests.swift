//
//  PDFImagePaginationTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09.10.2026.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Testing
@testable import TPPDF

struct PDFImagePaginationTests {
    @Test(arguments: [0, 1, 2, 3])
    func tallHeightFittedImageDoesNotBreakAnEmptyPage(alignmentIndex: Int) throws {
        let container: PDFContainer = [.contentLeft, .contentCenter, .contentRight, .none][alignmentIndex]
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        let availableHeight = PDFCalculations.calculateAvailableFrameHeight(for: generator, in: container)
        let image = PDFImageObject(image: PDFImage(
            image: Image(), size: CGSize(width: 180, height: 1800), sizeFit: .height
        ))

        let result = try image.calculate(generator: generator, container: container)

        #expect(result.count == 1)
        #expect(!result.contains { $0.1 is PDFPageBreakObject })
        #expect(abs(image.frame.height - availableHeight) < 0.001)
        #expect(image.frame.minY == generator.layout.margin.top)
    }

    @Test(arguments: [1000, 1001, 1002, 1901, 3000, 4096, 6016, 8001, 9000])
    func tallDefaultFittedImagesDoNotBreakAnEmptyPage(height: Int) throws {
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        let image = PDFImageObject(image: PDFImage(image: Image(), size: CGSize(width: 180, height: CGFloat(height))))

        let result = try image.calculate(generator: generator, container: .none)

        #expect(result.count == 1)
        #expect(!result.contains { $0.1 is PDFPageBreakObject })
    }

    @Test func heightFittedImageStillMovesPastExistingContent() throws {
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        let availableHeight = PDFCalculations.calculateAvailableFrameHeight(for: generator, in: .contentLeft)
        _ = try PDFSpaceObject(space: availableHeight - 60).calculate(generator: generator, container: .contentLeft)
        let image = PDFImageObject(image: PDFImage(
            image: Image(), size: CGSize(width: 180, height: 180), sizeFit: .height
        ))

        let result = try image.calculate(generator: generator, container: .contentLeft)

        try #require(result.count == 2)
        #expect(result[0].1 is PDFPageBreakObject)
        #expect(result[1].1 === image)
        #expect(image.frame.size == CGSize(width: 180, height: 180))
        #expect(image.frame.minY == generator.layout.margin.top)
    }
}
