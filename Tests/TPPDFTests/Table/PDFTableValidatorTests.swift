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
    func validatingTableWithEmptyOrConfiguredCellsSucceeds(configured: Bool) {
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

    @Test(arguments: ["empty", "alignmentCount", "alignmentRowSize", "columnWidths"])
    func invalidTableDataThrowsExpectedValidationError(scenario: String) throws {
        // Arrange
        let data = [["1|1", "1|2", "1|3", "1|4"], ["2|1", "2|2", "2|3", "2|4"]]
        let input = scenario == "empty" ? [] : data
        let alignments: [[PDFTableCellAlignment]]? = scenario == "alignmentCount" ? []
            : scenario == "alignmentRowSize" ? [[], []] : nil
        let widths: [CGFloat]? = scenario == "columnWidths" ? [] : nil
        let expectedMessage = scenario == "alignmentCount" ? "Data and alignment must be equal size!"
            : scenario == "columnWidths" ? "Data and widths for row with index 0 does not have the same amount!"
            : "Data and alignment for row with index 0 does not have the same amount!"

        // Act
        let caughtError = #expect(throws: PDFError.self) {
            try PDFTableValidator.validateTableData(data: input, alignments: alignments, columnWidths: widths)
        }

        // Assert
        let error = try #require(caughtError)
        switch error {
        case .tableIsEmpty:
            #expect(scenario == "empty")
        case let .tableStructureInvalid(message):
            #expect(scenario != "empty")
            #expect(message == expectedMessage)
        default:
            Issue.record("Unexpected validation error: \(error)")
        }
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
