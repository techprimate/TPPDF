//
//  PDFTableCellStyle.swift
//  Pods
//
//  Created by Philip Niedertscheider on 11/08/2017.
//
//

import Foundation

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
