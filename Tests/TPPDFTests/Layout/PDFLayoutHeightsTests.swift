//
//  PDFLayoutHeightsTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.05.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Testing
@testable import TPPDF

struct PDFLayoutHeightsTests {
    @Test func initializingHeightsUsesZeroForEveryRegion() {
        // Arrange
        let expectedHeader: [PDFContainer: CGFloat] = [.headerLeft: 0, .headerCenter: 0, .headerRight: 0]
        let expectedFooter: [PDFContainer: CGFloat] = [.footerLeft: 0, .footerCenter: 0, .footerRight: 0]

        // Act
        let heights = PDFLayoutHeights()

        // Assert
        #expect(heights.header == expectedHeader)
        #expect(heights.footer == expectedFooter)
        #expect(heights.content == 0)
    }

    @Test func maximumHeaderHeightUsesLargestContainer() {
        // Arrange
        var heights = PDFLayoutHeights()
        heights.header = [.headerLeft: 2, .headerCenter: 3, .headerRight: 4]

        // Act
        let maximum = heights.maxHeaderHeight()

        // Assert
        #expect(maximum == 4)
    }

    @Test func missingHeaderAndFooterHeightsHaveZeroMaximum() {
        // Arrange
        var heights = PDFLayoutHeights()
        heights.header = [:]
        heights.footer = [:]

        // Act
        let header = heights.maxHeaderHeight()
        let footer = heights.maxFooterHeight()

        // Assert
        #expect(header == 0)
        #expect(footer == 0)
    }

    @Test(arguments: [(0, 20.0), (1, 30.0), (2, 40.0), (3, 80.0), (4, 90.0), (5, 100.0), (6, 50.0), (7, 60.0), (8, 70.0)])
    func addingHeightUpdatesContainerAndSharesContentHeight(index: Int, expectedHeight: Double) {
        // Arrange
        var heights = PDFLayoutHeights()
        heights.header = [.headerLeft: 10, .headerCenter: 20, .headerRight: 30]
        heights.footer = [.footerLeft: 40, .footerCenter: 50, .footerRight: 60]
        heights.content = 70
        let containers = PDFContainer.all
        let container = containers[index]

        // Act
        if (3...5).contains(index) {
            for contentContainer in containers[3...index] {
                heights.add(10, to: contentContainer)
            }
        } else {
            heights.add(10, to: container)
        }
        let result: CGFloat? = container.isHeader ? heights.header[container]
            : container.isFooter ? heights.footer[container] : heights.content

        // Assert
        #expect(result == CGFloat(expectedHeight))
    }

    @Test func addingHeightToMissingContainersCreatesValues() {
        // Arrange
        var heights = PDFLayoutHeights()
        heights.header = [:]
        heights.footer = [:]

        // Act
        heights.add(10, to: .headerLeft)
        heights.add(20, to: .footerLeft)

        // Assert
        #expect(heights.header[.headerLeft] == 10)
        #expect(heights.footer[.footerLeft] == 20)
    }
}
