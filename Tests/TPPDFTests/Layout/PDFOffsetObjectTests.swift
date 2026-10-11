//
//  PDFOffsetObjectTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.14.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Testing
@testable import TPPDF

struct PDFOffsetObjectTests {
    @Test func initializingWithOffsetPreservesOffset() {
        // Arrange
        let offset: CGFloat = 20

        // Act
        let object = PDFOffsetObject(offset: offset)

        // Assert
        #expect(object.offset == offset)
    }

    @Test func calculatingSetsContainerOffsetAndReturnsObject() throws {
        // Arrange
        let object = PDFOffsetObject(offset: 20)
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        let container = PDFContainer.contentLeft

        // Act
        let result = try object.calculate(generator: generator, container: container)
        let offset = generator.layout.getContentOffset(in: container)

        // Assert
        #expect(offset == object.offset)
        #expect(result.count == 1)
        #expect(result.first?.0 == container)
        #expect(result.first?.1 as? PDFOffsetObject == object)
    }
}
