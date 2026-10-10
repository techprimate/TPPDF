//
//  PDFPaginationTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.04.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Testing
@testable import TPPDF

struct PDFPaginationTests {
    @Test func initializesWithDefaultPaginationSettings() {
        // Arrange
        let expectedRange = (start: 0, end: Int.max)

        // Act
        let pagination = PDFPagination()

        // Assert
        #expect(pagination.container == .none)
        #expect(pagination.style == .default)
        #expect(pagination.range.start == expectedRange.start)
        #expect(pagination.range.end == expectedRange.end)
        #expect(pagination.hiddenPages.isEmpty)
    }
}
