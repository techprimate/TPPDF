//
//  PDFSimpleText.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 31/10/2017.
//

#if os(iOS) || os(visionOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

/**
 * Plain text object with basic styling.
 *
 * The text of a ``PDFSimpleText`` will be styled using either the referenced ``PDFTextStyle`` set on `style`, or otherwise using the
 * styling of the parent container.
 *
 * Use this class for simple text drawing.
 * For advanced use cases see ``PDFAttributedText``.
 */
public class PDFSimpleText: PDFText {
    /// Text to be drawn
    public var text: String

    //// Line spacing if multiple lines
    public var spacing: CGFloat

    /// Weak reference to style used by this text object
    public weak var style: PDFTextStyle?

    /**
     * Creates a new simple text object
     *
     * - Parameters:
     *     - text: Text to be drawn
     *     - spacing: Spacing between text lines, defaults to `0`
     *     - style: Reference to ``PDFTextStyle``, defaults to `nil`
     */
    public init(text: String, spacing: CGFloat = 0, style: PDFTextStyle? = nil) {
        self.text = text
        self.spacing = spacing
        self.style = style
    }

    /// Creates a new `PDFSimpleText` with the same properties
    override public var copy: PDFText {
        PDFSimpleText(text: text, spacing: spacing, style: style)
    }

    // MARK: - Equatable

    /// nodoc
    override public func isEqual(to other: PDFDocumentObject) -> Bool {
        guard super.isEqual(to: other) else {
            return false
        }
        guard let otherText = other as? PDFSimpleText else {
            return false
        }
        guard text == otherText.text else {
            return false
        }
        guard spacing == otherText.spacing else {
            return false
        }
        guard style == otherText.style else {
            return false
        }
        return true
    }

    // MARK: - Hashable

    /// nodoc
    override public func hash(into hasher: inout Hasher) {
        hasher.combine(text)
        hasher.combine(spacing)
    }
}
