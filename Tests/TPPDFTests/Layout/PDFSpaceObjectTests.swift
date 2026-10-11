//
//  PDFSpaceObjectTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.14.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Testing
@testable import TPPDF

struct PDFSpaceObjectTests {
    @Test func initializingWithSpacePreservesSpace() {
        // Arrange
        let space: CGFloat = 20

        // Act
        let object = PDFSpaceObject(space: space)

        // Assert
        #expect(object.space == space)
    }

    @Test func calculatingSpacePositionsObjectAndAdvancesContentHeight() throws {
        // Arrange
        let object = PDFSpaceObject(space: 20)
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        let container = PDFContainer.contentLeft
        let previousHeight = generator.layout.heights.content

        // Act
        let result = try object.calculate(generator: generator, container: container)

        // Assert
        #expect(generator.layout.heights.content == previousHeight + object.frame.height)
        #expect(object.frame == CGRect(x: 60, y: 60, width: 475, height: 20))
        #expect(result.count == 1)
        #expect(result.first?.0 == container)
        #expect(result.first?.1 as? PDFSpaceObject === object)
    }
}
