//
//  PDFTableCell+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

extension PDFTableCell: Equatable {

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
        guard lhs.content == rhs.content else {
            return false
        }
        guard lhs.style == rhs.style else {
            return false
        }
        guard lhs.alignment == rhs.alignment else {
            return false
        }
        return true
    }

}
