//
//  PDFLayoutIndentationsTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.14.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Testing
@testable import TPPDF

struct PDFLayoutIndentationsTests {
    @Test func initializingIndentationsUsesZeroOnBothSidesOfEveryRegion() {
        // Arrange
        let expected: CGFloat = 0

        // Act
        let indentations = PDFLayoutIndentations()

        // Assert
        #expect(indentations.header.left == expected)
        #expect(indentations.header.right == expected)
        #expect(indentations.content.left == expected)
        #expect(indentations.content.right == expected)
        #expect(indentations.footer.left == expected)
        #expect(indentations.footer.right == expected)
    }

    @Test(arguments: 0..<9)
    func accessingContainerIndentationUsesItsRegion(index: Int) {
        // Arrange
        var indentations = PDFLayoutIndentations()
        indentations.header = (10, 20)
        indentations.content = (30, 40)
        indentations.footer = (50, 60)
        let container = PDFContainer.all[index]
        let expectedLeft: [CGFloat] = [10, 10, 10, 30, 30, 30, 50, 50, 50]
        let expectedRight: [CGFloat] = [20, 20, 20, 40, 40, 40, 60, 60, 60]

        // Act
        let left = indentations.leftIn(container: container)
        let right = indentations.rightIn(container: container)

        // Assert
        #expect(left == expectedLeft[index])
        #expect(right == expectedRight[index])
    }

    @Test(arguments: 0..<9, [false, true])
    func settingContainerIndentationReplacesEarlierValuesOnChosenSide(index: Int, right: Bool) {
        // Arrange
        var indentations = PDFLayoutIndentations()
        let containers = PDFContainer.all
        let values: [CGFloat] = [10, 20, 30]
        let regionStart = index / 3 * 3

        // Act
        for position in regionStart...index {
            if right {
                indentations.setRight(indentation: values[position % 3], in: containers[position])
            } else {
                indentations.setLeft(indentation: values[position % 3], in: containers[position])
            }
        }
        let result = right ? indentations.rightIn(container: containers[index])
            : indentations.leftIn(container: containers[index])

        // Assert
        #expect(result == values[index % 3])
    }
}
