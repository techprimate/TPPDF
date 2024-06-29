//
//  PDFTable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//

#if os(iOS) || os(visionOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

/**
 * A table is a two dimensional list.
 *
 * It can be styled and can contain different data.
 */
public class PDFTable: PDFDocumentObject {
    /// Styling used for drawing
    public var style: PDFTableStyle = PDFTableStyleDefaults.simple

    /// Two-dimensional array of cells
    public var cells: [[PDFTableCell]] = []

    /**
     * List of relative horizontal column widths.
     *
     * Values are between `0.0` and `1.0` and should sum up to `1.0` (100%)
     */
    public var widths: [CGFloat] = []

    /// Padding is the distance between the cell content and its borders.
    public var padding: CGFloat = 0

    /// Margin is the distance between the cell borders and other cells
    public var margin: CGFloat = 0

    /// Header rows will be drawn on every page
    public var showHeadersOnEveryPage: Bool = false

    //// Cells should split when overlapping page
    public var shouldSplitCellsOnPageBreak = false

    /**
     * Count of rows and columns in this table
     *
     * The size of the table needs to be defined beforehand, so that cells can be accessed using subscript accessors
     */
    public private(set) var size: (rows: Int, columns: Int)

    /**
     * Creates a new table with the given size and populates it with empty cells
     *
     * - Parameter size: Row and column count of table
     */
    public convenience init(size: (rows: Int, columns: Int)) {
        self.init(rows: size.rows, columns: size.columns)
    }

    /**
     * Creates a new table with the given size and populates it with empty cells.
     * - Parameters:
     *   - rows: Rows of table, must be greater than 0
     *   - columns: Columns of table, must be greater than 0
     */
    public init(rows: Int, columns: Int) {
        assert(rows >= 0, "Can't create a table with negative row count")
        assert(columns >= 0, "Can't create a table with negative column count")
        self.size = (rows: rows, columns: columns)
        self.cells = (0..<rows).map { _ in (0..<columns).map { _ in PDFTableCell() } }
        self.widths = (0..<columns).map { _ in 1.0 / CGFloat(columns) }
    }

    /// nodoc
    var copy: PDFTable {
        let table = PDFTable(size: size)
        table.style = style
        table.cells = cells
        table.widths = widths
        table.padding = padding
        table.margin = margin
        table.showHeadersOnEveryPage = showHeadersOnEveryPage
        return table
    }

    /// Shorthand accessor to the rows stored in ``PDFTable/cells``
    public var rows: PDFTableRows {
        self[rows: 0..<size.rows]
    }

    /// Shorthand accessor to the columns stored in ``PDFTable/cells``
    public var columns: PDFTableColumns {
        self[columns: 0..<size.columns]
    }

    /// Shorthand accessor to the cell values of this table
    public var content: [[PDFTableContentable?]] {
        get {
            rows.content
        }
        set {
            rows.content = newValue
        }
    }

    /// Shorthand accessor to the cell alignments of this table
    public var alignment: [[PDFTableCellAlignment]] {
        get {
            rows.alignment
        }
        set {
            rows.alignment = newValue
        }
    }

    // MARK: - Equatable

    /// nodoc
    override public func isEqual(to other: PDFDocumentObject) -> Bool {
        guard super.isEqual(to: other) else { return false }

        guard let otherTable = other as? PDFTable else {
            return false
        }
        guard style == otherTable.style else {
            return false
        }
        guard cells.count == otherTable.cells.count else {
            return false
        }
        for i in 0..<cells.count where cells[i] != otherTable.cells[i] {
            return false
        }
        guard widths == otherTable.widths else {
            return false
        }
        guard padding == otherTable.padding else {
            return false
        }
        guard margin == otherTable.margin else {
            return false
        }
        guard showHeadersOnEveryPage == otherTable.showHeadersOnEveryPage else {
            return false
        }
        return true
    }
}
