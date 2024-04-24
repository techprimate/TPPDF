//
//  PDFTableStyle.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 19/01/2017.
//

/**
 * Structure used to manage the styling of a ``PDFTable``
 *
 * The styling of a ``PDFTable`` can be defined by setting the property ``PDFTable/style``
 */
public class PDFTableStyle {
    /// Count of rows which will use the style configured in ``rowHeaderStyle``
    public var rowHeaderCount: Int

    /// Count of columns which will use the style configured in ``columnHeaderStyle``
    public var columnHeaderCount: Int

    /// Count of footers which will use the style configured in ``footerStyle``
    public var footerCount: Int

    /// Style used for the outer border
    public var outline: PDFLineStyle

    /// Style of cells in the header rows
    public var rowHeaderStyle: PDFTableCellStyle

    /// Style of cells in the header columns
    public var columnHeaderStyle: PDFTableCellStyle

    /// Style of cells in the footer rows
    public var footerStyle: PDFTableCellStyle

    /// Style of cells without special purpose
    public var contentStyle: PDFTableCellStyle

    /**
     * Style used for alternating content rows
     *
     * Setting this property will enable alternating row styling, which will apply this style to every other row
     */
    public var alternatingContentStyle: PDFTableCellStyle?

    /**
     * Create a table style
     *
     * - Parameters:
     *     - rowHeaderCount: Number of top rows which have header style
     *     - columnHeaderCount: Number of left columns with header style
     *     - footerCount: Number of footer rows with header style
     *     - outline: Line style of the outer borderlines
     *     - showHorizontalGridLines: Render horizontal grid lines
     *     - showVerticalGridLines: Render vertical grid lines
     *     - showRowHeaderGridLines: Render row header grid lines
     *     - showColumnHeaderGridLines: Render column header grid lines
     *     - showFooterGridLines: Render footer grid lines
     *     - rowHeaderStyle: The cell style of row header cells
     *     - columnHeaderStyle: The cell style of row header cells
     *     - footerStyle: The cell style of row header cells
     */
    public init(
        rowHeaderCount: Int = 1,
        columnHeaderCount: Int = 1,
        footerCount: Int = 1,
        outline: PDFLineStyle = PDFLineStyle(),
        rowHeaderStyle: PDFTableCellStyle = PDFTableCellStyle(),
        columnHeaderStyle: PDFTableCellStyle = PDFTableCellStyle(),
        footerStyle: PDFTableCellStyle = PDFTableCellStyle(),
        contentStyle: PDFTableCellStyle = PDFTableCellStyle(),
        alternatingContentStyle: PDFTableCellStyle? = nil
    ) {
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

    /// nodoc
    public func copy() -> PDFTableStyle {
        PDFTableStyle(
            rowHeaderCount: rowHeaderCount,
            columnHeaderCount: columnHeaderCount,
            footerCount: footerCount,
            outline: outline,
            rowHeaderStyle: rowHeaderStyle,
            columnHeaderStyle: columnHeaderStyle,
            footerStyle: footerStyle,
            contentStyle: contentStyle,
            alternatingContentStyle: alternatingContentStyle
        )
    }
}
