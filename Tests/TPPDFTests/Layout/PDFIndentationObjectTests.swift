//
//  PDFIndentationObjectTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.14.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Testing
@testable import TPPDF

struct PDFIndentationObjectTests {
    @Test func initializingPreservesIndentationSideAndSectionScope() {
        // Arrange
        let indentation: CGFloat = 20
        let left = false
        let insideSectionColumn = false

        // Act
        let object = PDFIndentationObject(indentation: indentation, left: left, insideSectionColumn: insideSectionColumn)

        // Assert
        #expect(object.indentation == indentation)
        #expect(object.left == left)
        #expect(object.insideSectionColumn == insideSectionColumn)
    }

    @Test(arguments: [false, true])
    func calculatingSetsIndentationOnChosenSideAndReturnsObject(left: Bool) throws {
        // Arrange
        let object = PDFIndentationObject(indentation: 20, left: left, insideSectionColumn: false)
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        let container = PDFContainer.contentLeft

        // Act
        let result = try object.calculate(generator: generator, container: container)
        let indentation = left ? generator.layout.indentation.leftIn(container: container)
            : generator.layout.indentation.rightIn(container: container)

        // Assert
        #expect(indentation == object.indentation)
        #expect(result.count == 1)
        #expect(result.first?.0 == container)
        #expect(result.first?.1 as? PDFIndentationObject == object)
    }
}
