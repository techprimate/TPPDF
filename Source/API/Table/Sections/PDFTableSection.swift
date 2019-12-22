//
//  PDFTableSection.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 20.12.19.
//

import Foundation

/**
 Reference to multiple rows and columns in a `PDFTable`
 */
public class PDFTableSection {

    /**
     References to cells in these rows and columns
     */
    public let cells: [[PDFTableCell]]

    private let table: PDFTable
    private let rowsRange: Range<Int>
    private let columnsRange: Range<Int>

    internal init(cells: [[PDFTableCell]], of table: PDFTable, in rowsRange: Range<Int>, and columnsRange: Range<Int>) {
        self.cells = cells
        self.table = table
        self.rowsRange = rowsRange
        self.columnsRange = columnsRange
    }
}

extension PDFTableSection {

    /// nodoc
    public func merge() {
        self.merge(with: nil)
    }

    /**
     Merges all cells by replacing them with the same reference.

     If no parameter `cell` is given, the first cell in the first row and the first column will be used.

     - parameter cell: Cell to use after merge, may be nil
     */
    public func merge(with cell: PDFTableCell? = nil) {
        for row in rowsRange {
            for column in columnsRange {
                table.cells[row][column] = cell ?? table.cells[rowsRange.first!][columnsRange.first!]
            }
        }
    }
}
