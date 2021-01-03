//
//  PDFSimpleText.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 31/10/2017.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/**
 Text and spacing of a text object.

 Use this class for simple and quick text drawing
 */
public class PDFSimpleText: PDFText {

    /**
     Text to be drawn
     */
    public var text: String

    /**
     Line spacing if multiple lines
     */
    public var spacing: CGFloat

    /**
     Weak reference to style used by this text object
     */
    public weak var style: PDFTextStyle?

    /**
     Initalizer

     - parameter text: Text to be drawn
     - parameter spacing: Spacing between text lines, defaults to 0
     - parameter style: Reference to style, defaults to nil
     */
    public init(text: String, spacing: CGFloat = 0, style: PDFTextStyle? = nil) {
        self.text = text
        self.spacing = spacing
        self.style = style
    }

    /**
     Creates a new `PDFSimpleText` with the same properties
     */
    override public var copy: PDFText {
        PDFSimpleText(text: self.text, spacing: self.spacing, style: self.style)
    }

    // MARK: - Equatable

    /// Compares two instances of `PDFSimpleText` for equality
    ///
    /// - Parameters:
    ///   - other: Another instance of `PDFSimpleText`
    /// - Returns: `true`, if `attributes`, `tag`, `text` and `spacing` equal; otherwise `false`
    override public func isEqual(to other: PDFDocumentObject) -> Bool {
        guard super.isEqual(to: other) else {
            return false
        }
        guard let otherText = other as? PDFSimpleText else {
            return false
        }
        guard self.text == otherText.text else {
            return false
        }
        guard self.spacing == otherText.spacing else {
            return false
        }
        guard self.style == otherText.style else {
            return false
        }
        return true
    }

    // MARK: - Hashable
}
