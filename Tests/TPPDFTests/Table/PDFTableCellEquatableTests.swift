//
//  PDFTableCellEquatableTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.16.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Testing
@testable import TPPDF

struct PDFTableCellEquatableTests {
    @Test(arguments: ["same", "content", "alignment", "style"])
    func equalityDependsOnContentAlignmentAndStyle(property: String) throws {
        // Arrange
        let cell = PDFTableCell()
        let otherCell: PDFTableCell
        switch property {
        case "content":
            let content = try PDFTableContent(content: "123")
            otherCell = PDFTableCell(content: try #require(content))
        case "alignment": otherCell = PDFTableCell(alignment: .bottomRight)
        case "style": otherCell = PDFTableCell(style: PDFTableCellStyle(colors: (fill: .green, text: .orange)))
        default: otherCell = PDFTableCell()
        }

        // Act
        let isEqual = cell == otherCell

        // Assert
        #expect(isEqual == (property == "same"))
    }
}
