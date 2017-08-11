//
//  PDFTableCellStyle.swift
//  Pods
//
//  Created by Philip Niedertscheider on 11/08/2017.
//
//

import Foundation

public struct PDFTableCellStyle {
    
    public var fillColor: UIColor
    public var textColor: UIColor
    
    public var font: UIFont
    
    public var borderLeft: PDFLineStyle
    public var borderTop: PDFLineStyle
    public var borderRight: PDFLineStyle
    public var borderBottom: PDFLineStyle
    
    public init(fillColor: UIColor = UIColor.clear, textColor: UIColor = UIColor.black, font: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize), borderLeft: PDFLineStyle = PDFLineStyle(), borderTop: PDFLineStyle = PDFLineStyle(), borderRight: PDFLineStyle = PDFLineStyle(), borderBottom: PDFLineStyle = PDFLineStyle()) {
        self.fillColor = fillColor
        self.textColor = textColor
        self.font = font
        
        self.borderLeft = borderLeft
        self.borderTop = borderTop
        self.borderRight = borderRight
        self.borderBottom = borderBottom
    }
}
