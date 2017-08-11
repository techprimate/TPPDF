//
//  TableStyle.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 19/01/2017.
//
//

import UIKit

public class TableStyle {
    
    public var rowHeaderCount: Int
    public var columnHeaderCount: Int
    public var footerCount: Int
 
    public var outline: LineStyle
    
    /// The cell style of row headers. Horizontal border lines are ignored, as these are defined in
    public var rowHeaderStyle: TableCellStyle
    public var columnHeaderStyle: TableCellStyle
    public var footerStyle: TableCellStyle
    public var contentStyle: TableCellStyle
    public var alternatingContentStyle: TableCellStyle?
    
    public var cellStyles: [TableCellPosition : TableCellStyle]
    
    
    /// Create a table style. All parameters are optional
    ///
    /// - Parameters:
    ///   - rowHeaderCount: Number of top rows which have header style, defaults to `1`
    ///   - columnHeaderCount: Number of left columns with header style, defaults to `1`
    ///   - footerCount: Number of footer rows with header style, defaults to `1`
    ///   - outline: Line style of the outer borderlines, defaults to `TableLineStyle.init`
    ///   - showHorizontalGridLines: Render horizontal grid lines, defaults to `true`
    ///   - showVerticalGridLines: Render vertical grid lines, defaults to `true`
    ///   - showRowHeaderGridLines: Render row header grid lines, defaults to `true`
    ///   - showColumnHeaderGridLines: Render column header grid lines, defaults to `true`
    ///   - showFooterGridLines: Render footer grid lines, defaults to `true`
    ///   - rowHeaderStyle: The cell style of row header cells, defaults to `TableLineStyle.init`
    ///   - columnHeaderStyle: The cell style of row header cells, defaults to `TableLineStyle.init`
    ///   - footerStyle: The cell style of row header cells, defaults to `TableLineStyle.init`
    ///   - cellStyles: Custom cell styles. Their position is set using a `TableCellPosition`, holding the row and column index
    public init(rowHeaderCount: Int = 1, columnHeaderCount: Int = 1, footerCount: Int = 1, outline: LineStyle = LineStyle(), rowHeaderStyle: TableCellStyle = TableCellStyle(), columnHeaderStyle: TableCellStyle = TableCellStyle(), footerStyle: TableCellStyle = TableCellStyle(), contentStyle: TableCellStyle = TableCellStyle(), alternatingContentStyle: TableCellStyle? = nil, cellStyles: [TableCellPosition : TableCellStyle] = [:]) {
        
        self.rowHeaderCount = rowHeaderCount
        self.columnHeaderCount = columnHeaderCount
        self.footerCount = footerCount
        
        self.outline = outline
        
        self.rowHeaderStyle = rowHeaderStyle
        self.columnHeaderStyle = columnHeaderStyle
        self.footerStyle = footerStyle
        self.contentStyle = contentStyle
        self.alternatingContentStyle = alternatingContentStyle
        
        self.cellStyles = cellStyles
    }
    
    public func setCellStyle(row: Int, column: Int, style: TableCellStyle) {
        self.cellStyles[TableCellPosition(row: row, column: column)] = style
    }
}
