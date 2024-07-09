//
//  PDFTextStyle.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 28.05.19.
//

#if os(iOS) || os(visionOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

/**
 * Structure to combine multiple aspects of text styling.
 *
 * Used to define text styling configuration in a global context.
 *
 * Furthermore, styles of a ``PDFDocument`` should be used to select headers for a ``PDFTableOfContent``.
 * See ``PDFTableOfContent`` for details.
 */
public class PDFTextStyle: Hashable {
    /// Name of style
    public var name: String

    /// Font of the text
    public var font: Font?

    /// Color of the text
    public var color: Color?

    /**
     * Creates a new style with the given parameters.
     *
     * By setting all parameters to `nil` (except `name`, which is required) the style can be used only to detect text objects
     * for the ``PDFTableOfContent``, without actually affecting the styling of the text.
     *
     * - Parameters:
     *     - name: Name of style
     *     - font: Font of text, defaults to `nil`
     *     - color: Color of text, defaults to `nil`
     */
    public init(name: String, font: Font? = nil, color: Color? = nil) {
        self.name = name
        self.font = font
        self.color = color
    }

    // MARK: - Equatable

    /// nodoc
    public static func == (lhs: PDFTextStyle, rhs: PDFTextStyle) -> Bool {
        guard lhs.name == rhs.name else {
            return false
        }
        guard lhs.font == rhs.font else {
            return false
        }
        guard lhs.color == rhs.color else {
            return false
        }
        return true
    }

    // MARK: - Hashable

    /// nodoc
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(font)
        hasher.combine(color)
    }
}
