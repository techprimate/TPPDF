//
//  PDFAttributedText+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

extension PDFAttributedText {

    /// Compares two instances of `PDFAttributedText` for equality
    ///
    /// - Parameters:
    ///   - lhs: One instance of `PDFAttributedText`
    ///   - rhs: Another instance of `PDFAttributedText`
    /// - Returns: `true`, if `attributes`, `tag` and `text` equal; otherwise `false`
    public static func == (lhs: PDFAttributedText, rhs: PDFAttributedText) -> Bool {
        // Properties of PDFObjectAttribute
        guard lhs.attributes == rhs.attributes else {
            return false
        }
        guard lhs.tag == rhs.tag else {
            return false
        }
        // Properties of PDFAttributedText
        guard lhs.text == rhs.text else {
            return false
        }
        return true
    }
}
