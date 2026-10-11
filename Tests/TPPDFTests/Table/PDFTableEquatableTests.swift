//
//  PDFTableEquatableTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.14.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Testing
@testable import TPPDF

struct PDFTableEquatableTests {
    @Test(arguments: ["same", "style", "cellCount", "cellContent", "widths", "padding", "margin", "headers"])
    func equalityDependsOnStyleCellsAndLayoutSettings(property: String) throws {
        // Arrange
        let table = PDFTable(rows: 0, columns: 0)
        let otherTable = PDFTable(rows: 0, columns: 0)
        switch property {
        case "style": otherTable.style = PDFTableStyle(rowHeaderCount: 2)
        case "cellCount": otherTable.cells = [[PDFTableCell(), PDFTableCell()]]
        case "cellContent":
            let content = try PDFTableContent(content: "TEST")
            table.cells = [[PDFTableCell(content: try #require(content)), PDFTableCell()]]
            otherTable.cells = [[PDFTableCell(), PDFTableCell()]]
        case "widths": otherTable.widths = [0.25, 0.75]
        case "padding": otherTable.padding = 100
        case "margin": otherTable.margin = 100
        case "headers": otherTable.showHeadersOnEveryPage = !table.showHeadersOnEveryPage
        default: break
        }

        // Act
        let isEqual = table == otherTable

        // Assert
        #expect(isEqual == (property == "same"))
    }
}
