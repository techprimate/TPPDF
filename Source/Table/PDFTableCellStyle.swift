//
//  PDFTableCellStyle.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//

public struct PDFTableCellStyle: PDFJSONSerializable {

    public var colors: (fill: UIColor, text: UIColor)
    public var borders: PDFTableCellBorders
    public var font: UIFont

    public init(colors: (fill: UIColor, text: UIColor) = (UIColor.clear, UIColor.black),
                borders: PDFTableCellBorders = PDFTableCellBorders(),
                font: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)) {
        self.colors = colors
        self.borders = borders
        self.font = font
    }
}
