//
//  PDFTableCellStyle.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//

#if os(iOS) || os(visionOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

/// Structure used to manage the custom style of a ``PDFTableCell``
public struct PDFTableCellStyle: Hashable {
    /// The cell fill (background) color and the text color
    public var colors: (fill: Color, text: Color)

    /// Custom border styling (see ``PDFTableCellBorders`` for details)
    public var borders: PDFTableCellBorders

    /// Font used for text content in cells
    public var font: Font

    /**
     * Creates a new cell style
     *
     * - Parameters:
     *     - colors: See ``PDFTableCellStyle/colors``
     *     - borders: See ``PDFTableCellStyle/borders``
     *     - font: See ``PDFTableCellStyle/font``
     */
    public init(
        colors: (fill: Color, text: Color) = (Color.clear, Color.black),
        borders: PDFTableCellBorders = PDFTableCellBorders(),
        font: Font = Font.systemFont(ofSize: PDFConstants.defaultFontSize)
    ) {
        self.colors = colors
        self.borders = borders
        self.font = font
    }

    // MARK: - Equatable

    /// nodoc
    public static func == (lhs: PDFTableCellStyle, rhs: PDFTableCellStyle) -> Bool {
        guard lhs.colors == rhs.colors else {
            return false
        }
        guard lhs.borders == rhs.borders else {
            return false
        }
        guard lhs.font == rhs.font else {
            return false
        }
        return true
    }

    // MARK: - Hashable

    /// nodoc
    public func hash(into hasher: inout Hasher) {
        hasher.combine(colors.fill)
        hasher.combine(colors.text)
        hasher.combine(borders)
        hasher.combine(font)
    }
}

public extension PDFTableCellStyle {
    /// Default cell style not displaying any background or borders
    static let none = PDFTableCellStyle(
        colors: (fill: Color.clear, text: Color.black),
        borders: .none,
        font: Font.systemFont(ofSize: PDFConstants.defaultFontSize)
    )
}
