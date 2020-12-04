//
//  PDFTableCell+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

extension PDFTableCell {

    /// Compares two instances of `PDFTableCell` for equality
    ///
    /// - Parameters:
    ///   - lhs: One instance of `PDFTableCell`
    ///   - rhs: Another instance of `PDFTableCell`
    /// - Returns: `true`, if `attributes`, `tag`, `content`, `alignment` and `style` equal; otherwise `false`
    public static func == (lhs: PDFTableCell, rhs: PDFTableCell) -> Bool {
        // Properties of PDFTableCell
        guard lhs.attributes == rhs.attributes else {
            return false
        }
        guard lhs.tag == rhs.tag else {
            return false
        }
        // Properties of PDFTableCell
        if lhs.content != rhs.content {
            return false
        }
        if lhs.alignment != rhs.alignment {
            return false
        }
        if lhs.style != rhs.style {
            return false
        }
        return true
    }

}
