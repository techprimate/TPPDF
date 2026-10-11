//
//  PDFTableValidatorTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.16.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Testing
@testable import TPPDF

struct PDFTableValidatorTests {
    @Test(arguments: [false, true])
    func validatingTableWithUnconfiguredOrConfiguredCellsSucceeds(configured: Bool) {
        // Arrange
        let table = PDFTable(rows: 2, columns: 4)
        if configured {
            table.widths = [0.1, 0.2, 0.3, 0.4]
            table.content = [["1|1", "1|2", "1|3", "1|4"], ["2|1", "2|2", "2|3", "2|4"]]
            table.alignment = [[.left, .top, .right, .bottom], [.topLeft, .topRight, .bottomRight, .bottomLeft]]
        }

        // Act and Assert
        #expect(throws: Never.self) {
            try PDFTableValidator.validateTable(table: table)
        }
    }

    @Test func emptyDataThrowsTableIsEmpty() {
        // Arrange
        let data: [[Any?]] = []

        // Act
        let error = #expect(throws: PDFError.self) {
            try PDFTableValidator.validateTableData(data: data)
        }

        // Assert
        guard case .tableIsEmpty? = error else {
            Issue.record("Expected tableIsEmpty, got \(String(describing: error))")
            return
        }
    }

    @Test(arguments: InvalidStructure.allCases)
    func invalidStructureReportsTheMismatchedRow(scenario: InvalidStructure) {
        // Arrange
        let input = scenario.input

        // Act
        let error = #expect(throws: PDFError.self) {
            try PDFTableValidator.validateTableData(data: input.data, alignments: input.alignments, columnWidths: input.widths)
        }

        // Assert
        guard case let .tableStructureInvalid(message)? = error else {
            Issue.record("Expected tableStructureInvalid, got \(String(describing: error))")
            return
        }
        #expect(message == input.message)
    }

    enum InvalidStructure: CaseIterable {
        case alignmentCount, firstRowAlignment, lastRowAlignment, firstRowWidths, lastRowWidths

        var input: (data: [[Any?]], alignments: [[PDFTableCellAlignment]]?, widths: [CGFloat]?, message: String) {
            switch self {
            case .alignmentCount:
                ([[1, 2], [3, 4]], [], nil, "Data and alignment must be equal size!")
            case .firstRowAlignment:
                ([[1, 2], [3, 4]], [[], []], nil,
                 "Data and alignment for row with index 0 does not have the same amount!")
            case .lastRowAlignment:
                ([[1, 2], [3, 4]], [[.left, .right], [.left]], nil,
                 "Data and alignment for row with index 1 does not have the same amount!")
            case .firstRowWidths:
                ([[1, 2], [3, 4]], nil, [], "Data and widths for row with index 0 does not have the same amount!")
            case .lastRowWidths:
                ([[1, 2], [3]], nil, [0.5, 0.5], "Data and widths for row with index 1 does not have the same amount!")
            }
        }
    }

    @Test(arguments: [false, true])
    func validDataAcceptsOptionalOrMatchingAlignmentAndWidths(configured: Bool) {
        // Arrange
        let data: [[Any?]] = [[nil, "text"], [1, 2.5]]
        let alignments: [[PDFTableCellAlignment]]? = configured ? [[.left, .right], [.top, .bottom]] : nil
        let widths: [CGFloat]? = configured ? [0.25, 0.75] : nil

        // Act and Assert
        #expect(throws: Never.self) {
            try PDFTableValidator.validateTableData(data: data, alignments: alignments, columnWidths: widths)
        }
    }

    @Test func emptyTableThrowsTableIsEmpty() {
        // Arrange
        let table = PDFTable(rows: 0, columns: 0)

        // Act
        let error = #expect(throws: PDFError.self) {
            try PDFTableValidator.validateTable(table: table)
        }

        // Assert
        guard case .tableIsEmpty? = error else {
            Issue.record("Expected tableIsEmpty, got \(String(describing: error))")
            return
        }
    }

    @Test(arguments: [false, true])
    func mergedHeadersDisableRepetitionOnlyWhenColumnHeightsDiffer(uneven: Bool) throws {
        // Arrange
        let table = PDFTable(rows: 4, columns: 2)
        table.style.columnHeaderCount = 1
        table.showHeadersOnEveryPage = true
        table[rows: 0..<2, column: 0].merge()
        if !uneven { table[rows: 0..<2, column: 1].merge() }

        // Act
        try PDFTableValidator.validateTable(table: table)

        // Assert
        #expect(table.showHeadersOnEveryPage == !uneven)
    }

    #if os(macOS) && swift(>=6.2)
    @Test func assigningContentWithWrongColumnCountTerminatesProcess() async {
        // Arrange
        let expectedExit = ExitTest.Condition.failure

        // Act
        let result = await #expect(processExitsWith: expectedExit) {
            let table = PDFTable(rows: 2, columns: 4)
            table.widths = [0.1, 0.2, 0.3, 0.4]
            table.content = [["1", "2"]]
        }

        // Assert
        #expect(result != nil)
    }
    #endif
}
