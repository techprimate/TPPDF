//
//  PDFGeneratorLayoutTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.12.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Testing
@testable import TPPDF

struct PDFGeneratorLayoutTests {
    @Test func gettingContentOffsetDelegatesToLayout() {
        // Arrange
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        let container = PDFContainer.contentCenter
        let expectedOffset = generator.layout.getContentOffset(in: container)

        // Act
        let offset = generator.getContentOffset(in: container)

        // Assert
        #expect(offset == expectedOffset)
    }

    @Test func settingContentOffsetUpdatesContainer() {
        // Arrange
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        let container = PDFContainer.contentCenter
        let value: CGFloat = 20

        // Act
        generator.setContentOffset(in: container, to: value)
        let offset = generator.getContentOffset(in: container)

        // Assert
        #expect(offset == value)
    }
}
