//
//  PDFTableCellStyle.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/**
 TODO: Documentation
 */
public struct PDFTableCellStyle {

    /**
     TODO: Documentation
     */
    public var colors: (fill: Color, text: Color)

    /**
     TODO: Documentation
     */
    public var borders: PDFTableCellBorders

    /**
     TODO: Documentation
     */
    public var font: Font

    /**
     TODO: Documentation
     */
    public init(colors: (fill: Color, text: Color) = (Color.clear, Color.black),
                borders: PDFTableCellBorders = PDFTableCellBorders(),
                font: Font = Font.systemFont(ofSize: PDFConstants.defaultFontSize)) {
        self.colors = colors
        self.borders = borders
        self.font = font
    }
}

extension PDFTableCellStyle {

    public static let none = PDFTableCellStyle(colors: (fill: Color.clear, text: Color.black),
                                               borders: .none,
                                               font: Font.systemFont(ofSize: PDFConstants.defaultFontSize))
}
