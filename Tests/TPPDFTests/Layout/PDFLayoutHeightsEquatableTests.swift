//
//  PDFLayoutHeightsEquatableTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.14.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Testing
@testable import TPPDF

struct PDFLayoutHeightsEquatableTests {
    @Test(arguments: ["same", "header", "footer", "content"])
    func equalityDependsOnHeightsForEachRegion(region: String) {
        // Arrange
        let heights = PDFLayoutHeights()
        var otherHeights = PDFLayoutHeights()
        switch region {
        case "header": otherHeights.header = [.headerLeft: 10]
        case "footer": otherHeights.footer = [.footerLeft: 10]
        case "content": otherHeights.content = 123
        default: break
        }

        // Act
        let isEqual = heights == otherHeights

        // Assert
        #expect(isEqual == (region == "same"))
    }
}
