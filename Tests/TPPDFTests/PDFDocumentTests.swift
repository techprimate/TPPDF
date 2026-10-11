//
//  PDFDocumentTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.04.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Testing
@testable import TPPDF

struct PDFDocumentTests {
    @Test func initializingWithLayoutPreservesLayoutAndUsesDefaultMetadataPaginationAndNoObjects() {
        // Arrange
        let layout = PDFPageLayout()
        let expectedInfo = PDFInfo()
        let expectedPagination = PDFPagination()

        // Act
        let document = PDFDocument(layout: layout)

        // Assert
        #expect(document.layout == layout)
        #expect(document.info == expectedInfo)
        #expect(document.pagination == expectedPagination)
        #expect(document.objects.isEmpty)
    }

    @Test func initializingWithPageFormatUsesItsLayout() {
        // Arrange
        let format = PDFPageFormat.a4
        let expectedLayout = format.layout

        // Act
        let document = PDFDocument(format: format)

        // Assert
        #expect(document.layout == expectedLayout)
    }
}
