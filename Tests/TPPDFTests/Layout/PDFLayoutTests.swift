//
//  PDFLayoutTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.14.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Testing
@testable import TPPDF

struct PDFLayoutTests {
    @Test func assigningHeightsAndIndentationsPreservesInstances() {
        // Arrange
        let layout = PDFLayout()
        let heights = PDFLayoutHeights()
        let indentations = PDFLayoutIndentations()

        // Act
        layout.heights = heights
        layout.indentation = indentations

        // Assert
        #expect(layout.heights == heights)
        #expect(layout.indentation == indentations)
    }

    @Test(arguments: 0..<9)
    func contentOffsetUsesContainerHeight(index: Int) {
        // Arrange
        let layout = PDFLayout()
        layout.heights.header = [.headerLeft: 1, .headerCenter: 2, .headerRight: 3]
        layout.heights.footer = [.footerLeft: 1, .footerCenter: 2, .footerRight: 3]
        layout.heights.content = 123
        let container = PDFContainer.all[index]
        let expected: [CGFloat] = [1, 2, 3, 123, 123, 123, 1, 2, 3]

        // Act
        let offset = layout.getContentOffset(in: container)

        // Assert
        #expect(offset == expected[index])
    }

    @Test(arguments: 0..<9)
    func settingContentOffsetUpdatesContainerHeight(index: Int) {
        // Arrange
        let layout = PDFLayout()
        let container = PDFContainer.all[index]
        let values: [CGFloat] = [111, 222, 333, 444, 555, 666, 777, 888, 999]
        let value = values[index]

        // Act
        layout.setContentOffset(in: container, to: value)
        let offset = layout.getContentOffset(in: container)

        // Assert
        #expect(offset == value)
    }

    @Test func resettingLayoutClearsPreviousHeightsAndIndentations() {
        // Arrange
        let layout = PDFLayout()
        layout.setContentOffset(in: .contentCenter, to: 123)
        layout.indentation.setLeft(indentation: 123, in: .contentCenter)
        let heights = layout.heights
        let indentations = layout.indentation

        // Act
        layout.reset()

        // Assert
        #expect(layout.heights != heights)
        #expect(layout.indentation != indentations)
    }
}
