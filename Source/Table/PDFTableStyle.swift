//
//  PDFTableStyle.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 19/01/2017.
//

public class PDFTableStyle: PDFJSONSerializable {

    public var rowHeaderCount: Int
    public var columnHeaderCount: Int
    public var footerCount: Int

    public var outline: PDFLineStyle

    /**
     The cell style of row headers. Horizontal border lines are ignored, as these are defined in
     */
    public var rowHeaderStyle: PDFTableCellStyle
    public var columnHeaderStyle: PDFTableCellStyle
    public var footerStyle: PDFTableCellStyle
    public var contentStyle: PDFTableCellStyle
    public var alternatingContentStyle: PDFTableCellStyle?

    /**
     Create a table style. All parameters are optional

     - Parameters:
       - rowHeaderCount: Number of top rows which have header style, defaults to `1`
       - columnHeaderCount: Number of left columns with header style, defaults to `1`
       - footerCount: Number of footer rows with header style, defaults to `1`
       - outline: Line style of the outer borderlines, defaults to `TablePDFLineStyle.init`
       - showHorizontalGridLines: Render horizontal grid lines, defaults to `true`
       - showVerticalGridLines: Render vertical grid lines, defaults to `true`
       - showRowHeaderGridLines: Render row header grid lines, defaults to `true`
       - showColumnHeaderGridLines: Render column header grid lines, defaults to `true`
       - showFooterGridLines: Render footer grid lines, defaults to `true`
       - rowHeaderStyle: The cell style of row header cells, defaults to `TablePDFLineStyle.init`
       - columnHeaderStyle: The cell style of row header cells, defaults to `TablePDFLineStyle.init`
       - footerStyle: The cell style of row header cells, defaults to `TablePDFLineStyle.init`
     */
    public init(rowHeaderCount: Int = 1,
                columnHeaderCount: Int = 1,
                footerCount: Int = 1,
                outline: PDFLineStyle = PDFLineStyle(),
                rowHeaderStyle: PDFTableCellStyle = PDFTableCellStyle(),
                columnHeaderStyle: PDFTableCellStyle = PDFTableCellStyle(),
                footerStyle: PDFTableCellStyle = PDFTableCellStyle(),
                contentStyle: PDFTableCellStyle = PDFTableCellStyle(),
                alternatingContentStyle: PDFTableCellStyle? = nil) {

        self.rowHeaderCount = rowHeaderCount
        self.columnHeaderCount = columnHeaderCount
        self.footerCount = footerCount

        self.outline = outline

        self.rowHeaderStyle = rowHeaderStyle
        self.columnHeaderStyle = columnHeaderStyle
        self.footerStyle = footerStyle
        self.contentStyle = contentStyle
        self.alternatingContentStyle = alternatingContentStyle
    }

    /**
     Creates a identical copy of this style
     */
    public func copy() -> PDFTableStyle {
        return PDFTableStyle(
            rowHeaderCount: self.rowHeaderCount,
            columnHeaderCount: self.columnHeaderCount,
            footerCount: self.footerCount,
            outline: self.outline,
            rowHeaderStyle: self.rowHeaderStyle,
            columnHeaderStyle: self.columnHeaderStyle,
            footerStyle: self.footerStyle,
            contentStyle: self.contentStyle,
            alternatingContentStyle: self.alternatingContentStyle
        )
    }

}
