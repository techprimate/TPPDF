//
//  PDFPaginationStyleTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.04.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Foundation
import Testing
@testable import TPPDF

struct PDFPaginationStyleTests {
    @Test func defaultStyleFormatsPageAndTotal() {
        // Arrange
        let style = PDFPaginationStyle.default

        // Act
        let text = style.format(page: 2, total: 7)

        // Assert
        #expect(text == "2 - 7")
    }

    @Test func romanStyleFormatsPageAndTotalUsingTemplate() {
        // Arrange
        let style = PDFPaginationStyle.roman(template: "%@ / %@")

        // Act
        let text = style.format(page: 2, total: 7)

        // Assert
        #expect(text == "II / VII")
    }

    @Test func customNumberStyleUsesFormatterAndTemplate() throws {
        // Arrange
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        let separator = try #require(Locale.current.decimalSeparator)
        let style = PDFPaginationStyle.customNumberFormat(template: "%@ +++ %@", formatter: formatter)

        // Act
        let text = style.format(page: 2, total: 7)

        // Assert
        #expect(text == "2\(separator)00 +++ 7\(separator)00")
    }

    @Test func customClosureFormatsPageAndTotal() {
        // Arrange
        let style = PDFPaginationStyle.customClosure { page, total in
            String(format: "%i - %i", page * page, 2 * total)
        }

        // Act
        let text = style.format(page: 3, total: 7)

        // Assert
        #expect(text == "9 - 14")
    }

    @Test func defaultStylesAreEqual() {
        // Arrange
        let style = PDFPaginationStyle.default
        let otherStyle = PDFPaginationStyle.default

        // Act
        let isEqual = style == otherStyle

        // Assert
        #expect(isEqual)
    }

    @Test(arguments: [("%@ - %@", true), ("%@ / %@", false)])
    func romanStyleEqualityDependsOnTemplate(otherTemplate: String, expectedEquality: Bool) {
        // Arrange
        let style = PDFPaginationStyle.roman(template: "%@ - %@")
        let otherStyle = PDFPaginationStyle.roman(template: otherTemplate)

        // Act
        let isEqual = style == otherStyle

        // Assert
        #expect(isEqual == expectedEquality)
    }

    @Test(arguments: [true, false], [true, false])
    func customNumberStyleEqualityRequiresSameTemplateAndFormatter(sameTemplate: Bool, sameFormatter: Bool) {
        // Arrange
        let formatter = NumberFormatter()
        let otherFormatter = sameFormatter ? formatter : NumberFormatter()
        let otherTemplate = sameTemplate ? "%@ - %@" : "%@ / %@"
        let style = PDFPaginationStyle.customNumberFormat(template: "%@ - %@", formatter: formatter)
        let otherStyle = PDFPaginationStyle.customNumberFormat(template: otherTemplate, formatter: otherFormatter)

        // Act
        let isEqual = style == otherStyle

        // Assert
        #expect(isEqual == (sameTemplate && sameFormatter))
    }

    @Test func customClosureStylesAreUnequalEvenWithSameFormatting() {
        // Arrange
        let style = PDFPaginationStyle.customClosure { page, total in "\(page) \(total)" }
        let otherStyle = PDFPaginationStyle.customClosure { page, total in "\(page) \(total)" }

        // Act
        let isEqual = style == otherStyle

        // Assert
        #expect(!isEqual)
    }
}
