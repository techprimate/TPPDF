//
//  EmptyDocumentTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 04.01.2021.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Foundation
import Testing
@testable import TPPDF

#if canImport(PDFKit)
import PDFKit

struct EmptyDocumentTests {
    @Test(arguments: [false, true])
    func generatingEmptyDocumentProducesOnePage(debug: Bool) throws {
        // Arrange
        let document = TPPDF.PDFDocument(format: .usLetter)
        let generator = PDFGenerator(document: document)
        generator.debug = debug

        // Act
        let data = try generator.generateData()
        let outputDocument = PDFKit.PDFDocument(data: data)
        let output = try #require(outputDocument)

        // Assert
        #expect(generator.totalPages == 1)
        #expect(output.pageCount == 1)
    }
}
#endif
