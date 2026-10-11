//
//  PDFContainerTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.09.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Testing
@testable import TPPDF

struct PDFContainerTests {
    @Test(arguments: [
        (0, false, false, false, false),
        (1, true, false, true, false), (2, true, false, false, false), (3, true, false, false, true),
        (4, false, false, true, false), (5, false, false, false, false), (6, false, false, false, true),
        (7, false, true, true, false), (8, false, true, false, false), (9, false, true, false, true),
    ])
    func containerIdentifiesItsRegionAndHorizontalAlignment(
        index: Int, expectedHeader: Bool, expectedFooter: Bool, expectedLeft: Bool, expectedRight: Bool
    ) {
        // Arrange
        let containers: [PDFContainer] = [
            .none, .headerLeft, .headerCenter, .headerRight, .contentLeft, .contentCenter, .contentRight,
            .footerLeft, .footerCenter, .footerRight,
        ]
        let container = containers[index]

        // Act
        let header = container.isHeader
        let footer = container.isFooter
        let left = container.isLeft
        let right = container.isRight

        // Assert
        #expect(header == expectedHeader)
        #expect(footer == expectedFooter)
        #expect(left == expectedLeft)
        #expect(right == expectedRight)
    }

    @Test func allContainersIncludesEveryPositionInOrderAndExcludesNone() {
        // Arrange
        let expected: [PDFContainer] = [
            .headerLeft, .headerCenter, .headerRight, .contentLeft, .contentCenter, .contentRight,
            .footerLeft, .footerCenter, .footerRight,
        ]

        // Act
        let containers = PDFContainer.all

        // Assert
        #expect(containers == expected)
    }
}
