//
//  PDFTableCellBorders.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

/**
 TODO: Documentation
 */
public struct PDFTableCellBorders {

    /**
     TODO: Documentation
     */
    public var left: PDFLineStyle

    /**
     TODO: Documentation
     */
    public var top: PDFLineStyle

    /**
     TODO: Documentation
     */
    public var right: PDFLineStyle

    /**
     TODO: Documentation
     */
    public var bottom: PDFLineStyle

    /**
     TODO: Documentation
     */
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
