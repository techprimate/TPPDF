//
//  PDFTableValidator.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/**
 PDFTable validation utility
 */
internal enum PDFTableValidator {

    /**
     Validates a given `table`.
     If no error is thrown, validation was successfull.

     - parameter table: Table for validation

     - throws:
        - `PDFError.tableIsEmpty`, if cells count is zero - should be avoided.
        - `PDFError`tableStructureInvalid`, if a row could not validated, see `PDFTableValidator.validateTableData(::)`
     */
    internal static func validateTable(table: PDFTable) throws {
        // Throw error when empty. Signalizes developer he tries to render an empty table. Might cause format errors
        if table.cells.isEmpty {
            throw PDFError.tableIsEmpty
        }

        // Check if headers are vertically merged unevenly, this means we can not have headers on every page
        var headerCellsPerColumn: [Int] = Array(repeating: 0, count: table.size.columns)
        // Get merge count of all header cells
        for colIdx in 0..<table.size.columns {
            let column = table[column: colIdx]
            var prevCell = column[0]
            var count = 0
            while count < table.size.rows && (count < table.style.columnHeaderCount || column[count] === prevCell) {
                prevCell = column[count]
                count += 1
            }
            headerCellsPerColumn[colIdx] = count
        }

        if headerCellsPerColumn.contains(where: { $0 != headerCellsPerColumn[0] }) {
            print("Can not display headers with uneven height due to merged cells on all pages. Disabling it...")
            table.showHeadersOnEveryPage = false
        }

        // Compare each data row, throw error when columns row count does not equal relativeColumnWidth count
        for (rowIdx, row) in table.cells.enumerated() where row.count != table.widths.count {
            throw PDFError.tableStructureInvalid(message: "Data and alignment for row with index \(rowIdx) does not have the same amount!")
        }
    }

    /**
     Validates the given `data`, `alignments` and `columnWidths`
     If no error is thrown, validation was successfull.

     - parameter data: Two dimensional array of optional objects
     - parameter alignments: Optional two dimensional array of alignments, defaults to `nil`
     - parameter columnWidhts: Optional array of column width values

     - throws:
        - `PDFError.tableIsEmpty`, if cells count is zero - should be avoided.
        - `PDFError.tableStructureInvalid`, if:
            - data row count and alignment row count do not equal
            - data column count and alignment column count do not equal
            - data column count and column count do not equal
     */
    internal static func validateTableData(data: [[Any?]], alignments: [[PDFTableCellAlignment]]? = nil, columnWidths: [CGFloat]? = nil) throws {
        // Throw error when empty. Signalizes developer he tries to render an empty table. Might cause format errors
        if data.isEmpty {
            throw PDFError.tableIsEmpty
        }

        // Throw error when data row count does not equal alignment row count
        if alignments != nil && data.count != alignments!.count {
            throw PDFError.tableStructureInvalid(message: "Data and alignment must be equal size!")
        }

        // Compare each data row
        for (rowIdx, row) in data.enumerated() {
            // Throw error when columns count does not equal alignment columns count
            if alignments != nil && row.count != alignments![rowIdx].count {
                throw PDFError.tableStructureInvalid(message: "Data and alignment for row with index \(rowIdx) does not have the same amount!")
            }

            // Throw error when columns row count does not equal relativeColumnWidth count
            if columnWidths != nil && row.count != columnWidths!.count {
                throw PDFError.tableStructureInvalid(message: "Data and widths for row with index \(rowIdx) does not have the same amount!")
            }
        }
    }
}
