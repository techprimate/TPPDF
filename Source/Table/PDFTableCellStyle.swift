//
//  PDFTableCellStyle.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//

/**
 TODO: Documentation
 */
public struct PDFTableCellStyle: PDFJSONSerializable {

    /**
     TODO: Documentation
     */
    public var colors: (fill: UIColor, text: UIColor)

    /**
     TODO: Documentation
     */
    public var borders: PDFTableCellBorders

    /**
     TODO: Documentation
     */
    public var font: UIFont

    /**
     TODO: Documentation
     */
    public init(colors: (fill: UIColor, text: UIColor) = (UIColor.clear, UIColor.black),
                borders: PDFTableCellBorders = PDFTableCellBorders(),
                font: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)) {
        self.colors = colors
        self.borders = borders
        self.font = font
    }
}
