//
//  PDFGeneratorTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.09.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Testing
@testable import TPPDF

struct PDFGeneratorTests {
    @Test func initializingGeneratorPreservesDocumentAndUsesEmptyLayoutAndFirstPage() {
        // Arrange
        let document = PDFDocument(format: .a4)
        let expectedLayout = PDFLayout()

        // Act
        let generator = PDFGenerator(document: document)

        // Assert
        #expect(generator.document === document)
        #expect(generator.headerFooterObjects.isEmpty)
        #expect(generator.layout == expectedLayout)
        #expect(generator.currentPage == 1)
        #expect(generator.totalPages == 1)
    }

    @Test(arguments: 0..<10)
    func everyContainerUsesDefaultFont(index: Int) {
        // Arrange
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        let containers: [PDFContainer] = [.none] + PDFContainer.all
        let expectedFont = Font.systemFont(ofSize: PDFConstants.defaultFontSize)

        // Act
        let font = generator.fonts[containers[index]]

        // Assert
        #expect(font == expectedFont)
    }

    @Test func resettingGeneratorRestoresFirstPageAndEmptyLayout() {
        // Arrange
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        generator.currentPage = 20
        generator.layout.heights.add(30, to: .contentLeft)
        generator.layout.indentation.setLeft(indentation: 45, in: .contentLeft)

        // Act
        generator.resetGenerator()

        // Assert
        #expect(generator.currentPage == 1)
        #expect(generator.layout.heights == PDFLayoutHeights())
        #expect(generator.layout.indentation == PDFLayoutIndentations())
    }
}
