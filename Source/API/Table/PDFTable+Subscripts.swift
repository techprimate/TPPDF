//
//  PDFTable+Subscripts.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 20.12.19.
//

import Foundation

extension PDFTable {

    // Single cell

    public subscript(row: Int, column: Int) -> PDFTableCell {
        return self.cells[row][column]
    }

    // Single line of cells

    public subscript(row: Int) -> PDFTableRow {
        return PDFTableRow(cells: self.cells[row], of: self, at: row)
    }

    public subscript(column: Int) -> PDFTableColumn {
        return PDFTableColumn(cells: self.cells.map({ row in row[column] }), of: self, at: column)
    }

    // Multiple rows

    public subscript(rows: ClosedRange<Int>) -> PDFTableRows {
        return self[rows.relative(to: cells)]
    }

    public subscript(rows: PartialRangeFrom<Int>) -> PDFTableRows {
        return self[rows.relative(to: cells)]
    }

    public subscript(rows: PartialRangeThrough<Int>) -> PDFTableRows {
        return self[rows.relative(to: cells)]
    }

    public subscript(rows: PartialRangeUpTo<Int>) -> PDFTableRows {
        return self[rows.relative(to: cells)]
    }

    public subscript(rows: Range<Int>) -> PDFTableRows {
        return PDFTableRows(
            rows: rows
                .map({ (position: $0, cells: self.cells[$0]) })
                .map({ PDFTableRow.init(cells: $0.cells, of: self, at: $0.position) }),
            of: self,
            in: rows)
    }

    // Multiple columns

    public subscript(columns: ClosedRange<Int>) -> PDFTableColumns {
        return self[columns.relative(to: columns.relative(to: cells[0]))]
    }

    public subscript(columns: PartialRangeFrom<Int>) -> PDFTableColumns {
        return self[columns.relative(to: columns.relative(to: cells[0]))]
    }

    public subscript(columns: PartialRangeThrough<Int>) -> PDFTableColumns {
        return self[columns.relative(to: columns.relative(to: cells[0]))]
    }

    public subscript(columns: PartialRangeUpTo<Int>) -> PDFTableColumns {
        return self[columns.relative(to: columns.relative(to: cells[0]))]
    }

    public subscript(columns: Range<Int>) -> PDFTableColumns {
        return PDFTableColumns(
            columns: columns
                .map({ column in
                    (position: column, cells: self.cells.map({ $0[column] }))
                })
                .map({ PDFTableColumn.init(cells: $0.cells, of: self, at: $0.position) }),
            of: self,
            in: columns)
    }

    // Section of cells

    public subscript(rows: Range<Int>, columns: ClosedRange<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }

    public subscript(rows: Range<Int>, columns: PartialRangeFrom<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }

    public subscript(rows: Range<Int>, columns: PartialRangeThrough<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }

    public subscript(rows: Range<Int>, columns: PartialRangeUpTo<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }

    public subscript(rows: Range<Int>, columns: Range<Int>) -> PDFTableSection {
        return PDFTableSection(cells: self.cells[rows].map({ Array($0[columns]) }), of: self, in: rows, and: columns)
    }

    public subscript(rows: ClosedRange<Int>, columns: Range<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }

    public subscript(rows: ClosedRange<Int>, columns: ClosedRange<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }

    public subscript(rows: ClosedRange<Int>, columns: PartialRangeFrom<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }

    public subscript(rows: ClosedRange<Int>, columns: PartialRangeThrough<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }

    public subscript(rows: ClosedRange<Int>, columns: PartialRangeUpTo<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }

    public subscript(rows: PartialRangeFrom<Int>, columns: Range<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }

    public subscript(rows: PartialRangeFrom<Int>, columns: ClosedRange<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }

    public subscript(rows: PartialRangeFrom<Int>, columns: PartialRangeFrom<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }

    public subscript(rows: PartialRangeFrom<Int>, columns: PartialRangeThrough<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }

    public subscript(rows: PartialRangeFrom<Int>, columns: PartialRangeUpTo<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }

    public subscript(rows: PartialRangeUpTo<Int>, columns: Range<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }

    public subscript(rows: PartialRangeUpTo<Int>, columns: ClosedRange<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }

    public subscript(rows: PartialRangeUpTo<Int>, columns: PartialRangeFrom<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }

    public subscript(rows: PartialRangeUpTo<Int>, columns: PartialRangeThrough<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }

    public subscript(rows: PartialRangeUpTo<Int>, columns: PartialRangeUpTo<Int>) -> PDFTableSection {
        return self[rows.relative(to: cells), columns.relative(to: cells[0])]
    }
}

public class PDFTableSection {

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

public class PDFTableRows {

    public let rows: [PDFTableRow]

    private let table: PDFTable
    private let range: Range<Int>

    internal init(rows: [PDFTableRow], of table: PDFTable, in range: Range<Int>) {
        self.rows = rows
        self.table = table
        self.range = range
    }
}

public class PDFTableRow {

    public let cells: [PDFTableCell]

    private let table: PDFTable
    private let position: Int

    internal init(cells: [PDFTableCell], of table: PDFTable, at position: Int) {
        self.cells = cells
        self.table = table
        self.position = position
    }
}

public class PDFTableColumns {

    public let columns: [PDFTableColumn]

    private let table: PDFTable
    private let range: Range<Int>

    internal init(columns: [PDFTableColumn], of table: PDFTable, in range: Range<Int>) {
        self.columns = columns
        self.table = table
        self.range = range
    }
}

public class PDFTableColumn {

    public let cells: [PDFTableCell]

    private let table: PDFTable
    private let position: Int

    internal init(cells: [PDFTableCell], of table: PDFTable, at position: Int) {
        self.cells = cells
        self.table = table
        self.position = position
    }
}
