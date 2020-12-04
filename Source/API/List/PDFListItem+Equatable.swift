//
//  PDFListItem+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

extension PDFListItem: Equatable {

    /// Compares two instances of `PDFListItem` for equality
    ///
    /// - Parameters:
    ///   - lhs: One instance of `PDFListItem`
    ///   - rhs: Another instance of `PDFListItem`
    /// - Returns: `true`, if `attributes`, `tag`, `content`, `children` and `symbol` equal; otherwise `false`
    public static func == (lhs: PDFListItem, rhs: PDFListItem) -> Bool {
        // Properties of PDFObjectAttribute
        guard lhs.attributes == rhs.attributes else {
            return false
        }
        guard lhs.tag == rhs.tag else {
            return false
        }
        // Properties of PDFListItem
        guard lhs.content == rhs.content else {
            return false
        }
        guard (lhs.children ?? []) == (rhs.children ?? []) else {
            return false
        }
        guard lhs.symbol == rhs.symbol else {
            return false
        }
        return true
    }
}
