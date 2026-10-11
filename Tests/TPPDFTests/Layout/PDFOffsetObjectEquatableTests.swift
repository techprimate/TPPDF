//
//  PDFOffsetObjectEquatableTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.14.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Testing
@testable import TPPDF

struct PDFOffsetObjectEquatableTests {
    @Test(arguments: [(10.0, true), (20.0, false)])
    func equalityDependsOnOffset(offset: Double, expectedEquality: Bool) {
        // Arrange
        let object = PDFOffsetObject(offset: 10)
        let otherObject = PDFOffsetObject(offset: CGFloat(offset))

        // Act
        let isEqual = object == otherObject

        // Assert
        #expect(isEqual == expectedEquality)
    }
}
