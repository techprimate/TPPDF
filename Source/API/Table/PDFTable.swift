//
//  PDFTable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/**
 A table is a two dimensional list.
 It can be styled and can contain different data.
 */
public class PDFTable: PDFDocumentObject {

    /**
     Styling used for drawing
     */
    public var style: PDFTableStyle = PDFTableStyleDefaults.simple

    /**
     All cell data
     */
    public var cells: [[PDFTableCell]] = []

    /**
     List of relative widths. Values are between 0.0 and 1.0 and should sum up to 1.0
     */
    public var widths: [CGFloat] = []

    /**
     Padding is the distance between the cell content and its borders.
     */
    public var padding: CGFloat = 0

    /**
     Margin is the distance between the cell borders and other cells
     */
    public var margin: CGFloat = 0

    /**
     Header rows will be drawn on every page
     */
    public var showHeadersOnEveryPage: Bool = false

    /**
     Cells should split when overlapping page
     */
    public var shouldSplitCellsOnPageBreak = false

    /**
     Count of rows and columns in this table
     */
    public private(set) var size: (rows: Int, columns: Int)

    public convenience init(size: (rows: Int, columns: Int) = (0, 0)) {
        self.init(rows: size.rows, columns: size.columns)
    }

    /**
     Creates a new table with the given size and populates it with empty cells.
     */
    public init(rows: Int = 0, columns: Int = 0) {
        self.size = (rows: rows, columns: columns)
        self.cells = (0..<rows).map({ _ in (0..<columns).map({ _ in PDFTableCell() }) })
        self.widths = (0..<columns).map({ _ in 1.0 / CGFloat(columns) })
    }

    /**
     Creates a new `PDFTable` with the same properties
     */
    internal var copy: PDFTable {
        let table = PDFTable()
        table.style = self.style
        table.cells = self.cells
        table.widths = self.widths
        table.padding = self.padding
        table.margin = self.margin
        table.showHeadersOnEveryPage = self.showHeadersOnEveryPage
        return table
    }

    // Access shorthands

    public var rows: PDFTableRows {
        self[rows: 0..<size.rows]
    }

    public var columns: PDFTableColumns {
        self[columns: 0..<size.columns]
    }

    public var content: [[PDFTableContentable?]] {
        get {
            self.rows.content
        }
        set {
            self.rows.content = newValue
        }
    }

    public var alignment: [[PDFTableCellAlignment]] {
        get {
            self.rows.alignment
        }
        set {
            self.rows.alignment = newValue
        }
    }
}
