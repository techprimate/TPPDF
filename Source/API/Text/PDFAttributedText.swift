//
//  PDFAttributedText.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 31/10/2017.
//

import Foundation

#if os(iOS) || os(visionOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

/**
 * Advanced text objects using an attributed string``Foundation.NSAttributedString`` as the internal structure.
 *
 * Use this class for advanced text drawing.
 * For simpler use cases, consider ``PDFSimpleText``.
 */
public class PDFAttributedText: PDFText {
    /// Attributed string which will be drawn in the PDF graphics context
    public var text: NSAttributedString

    /**
     * Creates a new attributed text object with the given `text`
     *
     * - Parameter text: ``Foundation.NSAttributedString`` to be drawn in the document
     */
    public init(text: NSAttributedString) {
        self.text = text
    }

    /// Creates a new ``PDFAttributedText`` with the same properties
    override public var copy: PDFText {
        PDFAttributedText(text: text)
    }

    // MARK: - Equatable

    /**
     * Compares two instances of `PDFAttributedText` for equality
     *
     * - Parameters:
     *    - lhs: One instance of `PDFAttributedText`
     *    - rhs: Another instance of `PDFAttributedText`
     *
     * - Returns: `true`, if `text` equal; otherwise `false`
     */
    override public func isEqual(to other: PDFDocumentObject) -> Bool {
        guard super.isEqual(to: other) else {
            return false
        }
        guard let otherAttributedText = other as? PDFAttributedText else {
            return false
        }
        guard text == otherAttributedText.text else {
            return false
        }
        return true
    }

    // MARK: - Hashable

    /// nodoc
    override public func hash(into hasher: inout Hasher) {
        hasher.combine(text)
    }
}
