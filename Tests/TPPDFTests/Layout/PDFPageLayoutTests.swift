//
//  PDFPageLayoutTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.14.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Testing
@testable import TPPDF

struct PDFPageLayoutTests {
    @Test func initializingPageLayoutUsesZeroSizeMarginsAndSpacing() {
        // Arrange
        let expectedSize = CGSize.zero
        let expectedMargin = EdgeInsets.zero

        // Act
        let layout = PDFPageLayout()

        // Assert
        #expect(layout.size == expectedSize)
        #expect(layout.margin == expectedMargin)
        #expect(layout.space.header == 0)
        #expect(layout.space.footer == 0)
    }

    @Test func settingSizeUpdatesBoundsWidthAndHeight() {
        // Arrange
        var layout = PDFPageLayout()
        let size = CGSize(width: 10, height: 20)

        // Act
        layout.size = size
        let bounds = layout.bounds
        let width = layout.width
        let height = layout.height

        // Assert
        #expect(bounds == CGRect(x: 0, y: 0, width: 10, height: 20))
        #expect(width == 10)
        #expect(height == 20)
    }
}
