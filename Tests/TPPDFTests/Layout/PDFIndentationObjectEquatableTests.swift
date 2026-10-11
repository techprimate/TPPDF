//
//  PDFIndentationObjectEquatableTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.16.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Testing
@testable import TPPDF

struct PDFIndentationObjectEquatableTests {
    @Test(arguments: [(0.0, true, true, true), (10.0, true, true, false), (0.0, false, true, false), (0.0, true, false, false)])
    func equalityDependsOnIndentationSideAndSectionScope(indentation: Double, left: Bool, insideSection: Bool, expectedEquality: Bool) {
        // Arrange
        let object = PDFIndentationObject(indentation: 0, left: true, insideSectionColumn: true)
        let otherObject = PDFIndentationObject(indentation: CGFloat(indentation), left: left, insideSectionColumn: insideSection)

        // Act
        let isEqual = object == otherObject

        // Assert
        #expect(isEqual == expectedEquality)
    }
}
