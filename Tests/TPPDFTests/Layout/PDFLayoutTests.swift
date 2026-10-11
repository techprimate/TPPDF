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
        layout.heights.header = [.headerLeft: 1, .headerCenter: 2, .headerRight: 3]
        layout.heights.content = 4
        layout.heights.footer = [.footerLeft: 5, .footerCenter: 6, .footerRight: 7]
        var expected: [CGFloat] = [1, 2, 3, 4, 4, 4, 5, 6, 7]
        if (3...5).contains(index) {
            expected.replaceSubrange(3...5, with: [value, value, value])
        } else {
            expected[index] = value
        }

        // Act
        layout.setContentOffset(in: container, to: value)

        // Assert
        for (position, otherContainer) in PDFContainer.all.enumerated() {
            #expect(layout.getContentOffset(in: otherContainer) == expected[position])
        }
    }

    @Test func resettingLayoutClearsEveryRegionAndMargins() {
        // Arrange
        let layout = PDFLayout()
        layout.margin = EdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
        for container in PDFContainer.all {
            layout.setContentOffset(in: container, to: 123)
            layout.indentation.setLeft(indentation: 12, in: container)
            layout.indentation.setRight(indentation: 34, in: container)
        }

        // Act
        layout.reset()

        // Assert
        for container in PDFContainer.all {
            #expect(layout.getContentOffset(in: container) == 0)
            #expect(layout.indentation.leftIn(container: container) == 0)
            #expect(layout.indentation.rightIn(container: container) == 0)
        }
        #expect(layout.margin == .zero)
    }
}
