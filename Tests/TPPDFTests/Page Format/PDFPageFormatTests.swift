//
//  PDFPageFormatTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.04.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Testing
@testable import TPPDF

struct PDFPageFormatTests {
    @Test func unrelatedSeriesFallBackToTheFormatSize() {
        // Arrange
        let cFormat = PDFPageFormat.c0
        let usFormat = PDFPageFormat.usLegal

        // Act
        let fallbackSizes = [cFormat.usSize, cFormat.ansiSize, cFormat.aSize, cFormat.bSize]
        let usFallbackSize = usFormat.cSize

        // Assert
        #expect(fallbackSizes.allSatisfy { $0 == cFormat.size })
        #expect(usFallbackSize == usFormat.size)
    }

    @Test func landscapeSizeSwapsWidthAndHeight() {
        // Arrange
        let format = PDFPageFormat.a0
        let expectedSize = CGSize(width: format.size.height, height: format.size.width)

        // Act
        let size = format.landscapeSize

        // Assert
        #expect(size == expectedSize)
    }
}
