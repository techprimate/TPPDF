//
//  PDFTableCellBorders.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

public struct PDFTableCellBorders {

    public var left: PDFLineStyle
    public var top: PDFLineStyle
    public var right: PDFLineStyle
    public var bottom: PDFLineStyle

    public init(left: PDFLineStyle = PDFLineStyle.none,
                top: PDFLineStyle = PDFLineStyle.none,
                right: PDFLineStyle = PDFLineStyle.none,
                bottom: PDFLineStyle = PDFLineStyle.none) {
        self.left = left
        self.top = top
        self.right = right
        self.bottom = bottom
    }
}
