//
//  PDFLayoutIndentationsEquatableTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.14.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Testing
@testable import TPPDF

struct PDFLayoutIndentationsEquatableTests {
    @Test(arguments: ["same", "header", "content", "footer"])
    func equalityDependsOnIndentationsForEveryRegion(region: String) {
        // Arrange
        let indentations = PDFLayoutIndentations()
        var otherIndentations = PDFLayoutIndentations()
        switch region {
        case "header": otherIndentations.header = (10, 20)
        case "content": otherIndentations.content = (10, 20)
        case "footer": otherIndentations.footer = (10, 20)
        default: break
        }

        // Act
        let isEqual = indentations == otherIndentations

        // Assert
        #expect(isEqual == (region == "same"))
    }
}
