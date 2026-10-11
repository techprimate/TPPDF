//
//  PDFLayoutEquatableTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.14.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Testing
@testable import TPPDF

struct PDFLayoutEquatableTests {
    @Test(arguments: ["same", "heights", "indentation"])
    func equalityDependsOnHeightsAndIndentations(property: String) {
        // Arrange
        let layout = PDFLayout()
        let otherLayout = PDFLayout()
        switch property {
        case "heights": otherLayout.heights.content = 123
        case "indentation": otherLayout.indentation.header.left = 100
        default: break
        }

        // Act
        let isEqual = layout == otherLayout

        // Assert
        #expect(isEqual == (property == "same"))
    }
}
