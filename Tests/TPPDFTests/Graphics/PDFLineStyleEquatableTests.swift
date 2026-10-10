//
//  PDFLineStyleEquatableTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.12.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Testing
@testable import TPPDF

struct PDFLineStyleEquatableTests {
    @Test func stylesWithSameValuesAreEqual() {
        // Arrange
        let style = PDFLineStyle(type: .dotted, color: .orange, width: 0.25)
        let otherStyle = PDFLineStyle(type: .dotted, color: .orange, width: 0.25)

        // Act
        let isEqual = style == otherStyle

        // Assert
        #expect(isEqual)
    }

    @Test(arguments: ["type", "color", "width"])
    func stylesWithDifferentValuesAreUnequal(property: String) {
        // Arrange
        let style = PDFLineStyle(type: .dotted, color: .orange, width: 0.25)
        var otherStyle = PDFLineStyle(type: .dotted, color: .orange, width: 0.25)
        switch property {
        case "type": otherStyle.type = .dashed
        case "color": otherStyle.color = .red
        default: otherStyle.width = 1
        }

        // Act
        let isEqual = style == otherStyle

        // Assert
        #expect(!isEqual)
    }
}
