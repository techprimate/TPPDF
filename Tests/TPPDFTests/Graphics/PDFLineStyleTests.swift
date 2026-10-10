//
//  PDFLineStyleTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.12.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Testing
@testable import TPPDF

struct PDFLineStyleTests {
    @Test func initializingWithoutArgumentsUsesDefaultStyle() {
        // Arrange
        let expectedType = PDFLineType.full
        let expectedColor = Color.black
        let expectedWidth: CGFloat = 0.25

        // Act
        let style = PDFLineStyle()

        // Assert
        #expect(style.type == expectedType)
        #expect(style.color == expectedColor)
        #expect(style.width == expectedWidth)
    }

    @Test func initializingWithArgumentsPreservesStyleValues() {
        // Arrange
        let type = PDFLineType.dotted
        let color = Color.orange
        let width: CGFloat = 1.25

        // Act
        let style = PDFLineStyle(type: type, color: color, width: width)

        // Assert
        #expect(style.type == type)
        #expect(style.color == color)
        #expect(style.width == width)
    }

    @Test func noneStyleHasNoLineAndZeroWidth() {
        // Arrange
        let expectedStyle = PDFLineStyle(type: .none, color: .black, width: 0)

        // Act
        let style = PDFLineStyle.none

        // Assert
        #expect(style == expectedStyle)
    }
}
