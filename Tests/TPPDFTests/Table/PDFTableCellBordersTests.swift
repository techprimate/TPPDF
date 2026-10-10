//
//  PDFTableCellBordersTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.16.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Testing
@testable import TPPDF

struct PDFTableCellBordersTests {
    @Test func initializingWithoutBordersUsesNoLineOnEveryEdge() {
        // Arrange
        let expectedStyle = PDFLineStyle.none

        // Act
        let borders = PDFTableCellBorders()

        // Assert
        #expect(borders.left == expectedStyle)
        #expect(borders.top == expectedStyle)
        #expect(borders.right == expectedStyle)
        #expect(borders.bottom == expectedStyle)
    }

    @Test(arguments: ["left", "top", "right", "bottom"])
    func initializingOneBorderPreservesItsStyle(edge: String) {
        // Arrange
        let style = PDFLineStyle(type: .dotted, color: .orange, width: 10)

        // Act
        let borders: PDFTableCellBorders
        let actualStyle: PDFLineStyle
        switch edge {
        case "left":
            borders = PDFTableCellBorders(left: style)
            actualStyle = borders.left
        case "top":
            borders = PDFTableCellBorders(top: style)
            actualStyle = borders.top
        case "right":
            borders = PDFTableCellBorders(right: style)
            actualStyle = borders.right
        default:
            borders = PDFTableCellBorders(bottom: style)
            actualStyle = borders.bottom
        }

        // Assert
        #expect(actualStyle == style)
    }
}
