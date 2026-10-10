//
//  PDFPageFormatLayoutTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 27.12.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Testing
@testable import TPPDF

struct PDFPageFormatLayoutTests {
    @Test func shorthandCreatesLayoutWithDefaultMarginsAndSpacing() {
        // Arrange
        let format = PDFPageFormat.a0
        let expectedLayout = PDFPageLayout(
            size: CGSize(width: 2384, height: 3370),
            margin: EdgeInsets(top: 60, left: 60, bottom: 60, right: 60),
            space: (header: 15, footer: 15)
        )

        // Act
        let layout = format.layout

        // Assert
        #expect(layout == expectedLayout)
    }
}
