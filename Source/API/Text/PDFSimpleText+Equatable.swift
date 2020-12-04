//
//  PDFSimpleText+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

/**
 TODO: Documentation
 */
extension PDFSimpleText: Equatable {

    /// Compares two instances of `PDFSimpleText` for equality
    ///
    /// - Parameters:
    ///   - lhs: One instance of `PDFSimpleText`
    ///   - rhs: Another instance of `PDFSimpleText`
    /// - Returns: `true`, if `attributes`, `tag`, `text` and `spacing` equal; otherwise `false`
    public static func == (lhs: PDFSimpleText, rhs: PDFSimpleText) -> Bool {
        // Properties of PDFObjectAttribute
        guard lhs.attributes == rhs.attributes else {
            return false
        }
        guard lhs.tag == rhs.tag else {
            return false
        }
        // Properties of PDFSimpleText
        guard lhs.text == rhs.text else {
            return false
        }
        guard lhs.spacing == rhs.spacing else {
            return false
        }
        return true
    }
}
