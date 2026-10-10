//
//  PDFPaginationStyleEquatableTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 27.12.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Foundation
import Testing
@testable import TPPDF

struct PDFPaginationStyleEquatableTests {
    @Test func defaultStylesAreEqual() {
        // Arrange
        let style = PDFPaginationStyle.default
        let otherStyle = PDFPaginationStyle.default

        // Act
        let isEqual = style == otherStyle

        // Assert
        #expect(isEqual)
    }

    @Test(arguments: [(0, 0, true), (0, 1, true), (0, 2, false), (1, 2, false)])
    func romanStyleEqualityDependsOnTemplate(firstIndex: Int, secondIndex: Int, expectedEquality: Bool) {
        // Arrange
        let styles = [
            PDFPaginationStyle.roman(template: "123"),
            .roman(template: "123"),
            .roman(template: "456"),
        ]

        // Act
        let isEqual = styles[firstIndex] == styles[secondIndex]

        // Assert
        #expect(isEqual == expectedEquality)
    }

    @Test(arguments: [0, 1, 2, 3], [0, 1, 2, 3])
    func numberStyleEqualityDependsOnTemplateAndFormatter(firstIndex: Int, secondIndex: Int) {
        // Arrange
        let firstFormatter = NumberFormatter()
        firstFormatter.numberStyle = .percent
        let secondFormatter = NumberFormatter()
        secondFormatter.numberStyle = .decimal
        let styles = [
            PDFPaginationStyle.customNumberFormat(template: "123", formatter: firstFormatter),
            .customNumberFormat(template: "123", formatter: secondFormatter),
            .customNumberFormat(template: "456", formatter: firstFormatter),
            .customNumberFormat(template: "456", formatter: secondFormatter),
        ]

        // Act
        let isEqual = styles[firstIndex] == styles[secondIndex]

        // Assert
        #expect(isEqual == (firstIndex == secondIndex))
    }

    @Test func customClosureStyleIsNotEqualToItselfAndCanReturnEmptyText() {
        // Arrange
        let style = PDFPaginationStyle.customClosure { _, _ in "" }

        // Act
        let isEqual = style == style
        let text = style.format(page: 1, total: 2)

        // Assert
        #expect(!isEqual)
        #expect(text.isEmpty)
    }
}
