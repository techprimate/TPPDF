//
//  PDFPageBreakObjectEquatableTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.14.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Testing
@testable import TPPDF

struct PDFPageBreakObjectEquatableTests {
    @Test func pageBreakObjectsAreEqual() {
        // Arrange
        let object = PDFPageBreakObject()
        let otherObject = PDFPageBreakObject()

        // Act
        let isEqual = object == otherObject

        // Assert
        #expect(isEqual)
    }
}
