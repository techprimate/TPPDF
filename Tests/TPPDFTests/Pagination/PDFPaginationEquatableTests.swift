//
//  PDFPaginationEquatableTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.04.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Testing
@testable import TPPDF

struct PDFPaginationEquatableTests {
    @Test(arguments: ["container", "style", "range", "hiddenPages"])
    func differingSettingsMakePaginationUnequal(property: String) {
        // Arrange
        let pagination = PDFPagination()
        var otherPagination = PDFPagination()
        switch property {
        case "container": otherPagination.container = .contentLeft
        case "style": otherPagination.style = .roman(template: "%@ / %@")
        case "range": otherPagination.range = (start: 2, end: 5)
        default: otherPagination.hiddenPages = [1, 2, 3]
        }

        // Act
        let isEqual = pagination == otherPagination

        // Assert
        #expect(!isEqual)
    }
}
