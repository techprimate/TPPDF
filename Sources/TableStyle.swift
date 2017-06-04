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

public struct TableCellPosition : Hashable {
    
    public var row = -1
    public var column = -1
    
    public init(row: Int, column: Int) {
        self.row = row
        self.column = column
    }
    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    public var hashValue: Int {
        return row * row + column
    }
}

/// Returns a Boolean value indicating whether two values are equal.
///
/// Equality is the inverse of inequality. For any values `a` and `b`,
/// `a == b` implies that `a != b` is `false`.
///
/// - Parameters:
///   - lhs: A value to compare.
///   - rhs: Another value to compare.
public func ==(lhs: TableCellPosition, rhs: TableCellPosition) -> Bool {
    return lhs.row == rhs.row && lhs.column == rhs.column
}


public struct TableCellStyle {
    
    public var fillColor: UIColor
    public var textColor: UIColor
    
    public var font: UIFont
    
    public var borderLeft: LineStyle
    public var borderTop: LineStyle
    public var borderRight: LineStyle
    public var borderBottom: LineStyle
    
    public init(fillColor: UIColor = UIColor.clear, textColor: UIColor = UIColor.black, font: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize), borderLeft: LineStyle = LineStyle(), borderTop: LineStyle = LineStyle(), borderRight: LineStyle = LineStyle(), borderBottom: LineStyle = LineStyle()) {
        self.fillColor = fillColor
        self.textColor = textColor
        self.font = font
        
        self.borderLeft = borderLeft
        self.borderTop = borderTop
        self.borderRight = borderRight
        self.borderBottom = borderBottom
    }
}

/// This struct defines how a line or border of a table is drawn.
public struct LineStyle {
    
    /// These types of lines are available for rendering. Used in `TableStyle` and `TableCellStyle`
    ///
    /// - full: Line without any breaks
    /// - dashed: Line consists out of short dashes
    /// - dotted: Lines consists out of dots
    public enum LineType {
        case none, full, dashed, dotted
    }
    
    /// Defines the type of this line
    public var type: LineType
    /// Defines the color of this line
    public var color: UIColor
    /// Defines the width of this line
    public var width: Double
    
    /// Initialize a table line style
    ///
    /// - Parameters:
    ///   - type: of Line
    ///   - color: of Line
    ///   - width: of Line
    public init(type: LineType = .full, color: UIColor = UIColor.black, width: Double = 0.25) {
        self.type = type
        self.color = color
        self.width = width
    }
}
