//
//  PDFTableCellAlignmentTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.12.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Testing
@testable import TPPDF

struct PDFTableCellAlignmentTests {
    @Test(arguments: [
        (0, true, false, true, false),
        (1, true, false, false, false),
        (2, true, false, false, true),
        (3, false, false, true, false),
        (4, false, false, false, false),
        (5, false, false, false, true),
        (6, false, true, true, false),
        (7, false, true, false, false),
        (8, false, true, false, true),
    ])
    func alignmentIdentifiesItsVerticalAndHorizontalEdges(
        index: Int, expectedTop: Bool, expectedBottom: Bool, expectedLeft: Bool, expectedRight: Bool
    ) {
        // Arrange
        let alignments: [PDFTableCellAlignment] = [
            .topLeft, .top, .topRight, .left, .center, .right, .bottomLeft, .bottom, .bottomRight,
        ]
        let alignment = alignments[index]

        // Act
        let isTop = alignment.isTop
        let isBottom = alignment.isBottom
        let isLeft = alignment.isLeft
        let isRight = alignment.isRight

        // Assert
        #expect(isTop == expectedTop)
        #expect(isBottom == expectedBottom)
        #expect(isLeft == expectedLeft)
        #expect(isRight == expectedRight)
    }
}
