//
//  PDFTable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//

/**
 A table is a two dimensional list.
 It can be styled and can contain different data:

 -
 */
public class PDFTable: PDFJSONSerializable {

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
     Public initalizer to create a table outside framework
     */
    public init() {}

    /**
     Generates cells from given `data` and `alignments` and stores the result in the instance variable `cells`

     - throws: `PDFError` if table validation fails. See `PDFTableValidator.validateTableData(::)` for details
     */
    public func generateCells(data: [[Any?]], alignments: [[PDFTableCellAlignment]]) throws {
        try PDFTableValidator.validateTableData(data: data, alignments: alignments)

        self.cells = []

        for (rowIndex, row) in data.enumerated() {
            var contentRow = [PDFTableCell]()
            for (colIndex, col) in row.enumerated() {
                let content = try PDFTableContent(content: col)
                let alignment = alignments[rowIndex][colIndex]

                let cell = PDFTableCell(content: content, alignment: alignment)
                contentRow.append(cell)
            }
            self.cells.append(contentRow)
        }
    }

    /**
     Modify the cell style of at the position defined by `row` and `column`
     */
    public func setCellStyle(row rowIndex: Int, column columnIndex: Int, style cellStyle: PDFTableCellStyle?) throws {
        if rowIndex < 0 || rowIndex >= cells.count {
            throw PDFError.tableIndexOutOfBounds(index: rowIndex, length: cells.count)
        }
        if columnIndex < 0 || columnIndex >= cells[rowIndex].count {
            throw PDFError.tableIndexOutOfBounds(index: columnIndex, length: cells[rowIndex].count)
        }

        let cell = cells[rowIndex][columnIndex]
        cell.style = cellStyle
    }

    var copy: PDFTable {
        let table = PDFTable()
        table.style = self.style
        table.cells = self.cells
        table.widths = self.widths
        table.padding = self.padding
        table.margin = self.margin
        table.showHeadersOnEveryPage = self.showHeadersOnEveryPage
        return table
    }
}
