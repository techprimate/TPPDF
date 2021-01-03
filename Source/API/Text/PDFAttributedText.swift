//
//  PDFAttributedText.swift
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
 Attributed text objects hold an instance of `NSAttributedString`

 Use this class for advanced text drawing
 */
public class PDFAttributedText: PDFText {

    /**
     Text which will be drawn
     */
    public var text: NSAttributedString

    /**
     Initializer

     - parameter text: Text, which will be drawn
     */
    public init(text: NSAttributedString) {
        self.text = text
    }

    /**
     Creats a new `PDFAttributedText` with the same properties
     */
    override public var copy: PDFText {
        PDFAttributedText(text: text)
    }

    // MARK: - Equatable

    /// Compares two instances of `PDFAttributedText` for equality
    ///
    /// - Parameters:
    ///   - lhs: One instance of `PDFAttributedText`
    ///   - rhs: Another instance of `PDFAttributedText`
    /// - Returns: `true`, if `attributes`, `tag` and `text` equal; otherwise `false`
    override public func isEqual(to other: PDFDocumentObject) -> Bool {
        guard super.isEqual(to: other) else {
            return false
        }
        guard let otherAttributedText = other as? PDFAttributedText else {
            return false
        }
        guard self.text == otherAttributedText.text else {
            return false
        }
        return true
    }

    // MARK: - Hasha
}
