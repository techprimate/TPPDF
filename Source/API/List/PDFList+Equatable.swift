//
//  PDFList+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

extension PDFList {

    /// Compares two instances of `PDFList` for equality
    ///
    /// - Parameters:
    ///   - lhs: One instance of `PDFList`
    ///   - rhs: Another instance of `PDFList`
    /// - Returns: `true`, if `levelIndentations` and `items` equal; otherwise `false`
    public static func == (lhs: PDFList, rhs: PDFList) -> Bool {
        // Properties of PDFObjectAttribute
        guard lhs.attributes == rhs.attributes else {
            return false
        }
        guard lhs.tag == rhs.tag else {
            return false
        }
        // Properties of PDFList
        guard lhs.levelIndentations.count == rhs.levelIndentations.count else {
            return false
        }
        for (idx, indentation) in lhs.levelIndentations.enumerated() where rhs.levelIndentations[idx] != indentation {
            return false
        }
        guard lhs.items.count == rhs.items.count else {
            return false
        }
        for (idx, item) in lhs.items.enumerated() where rhs.items[idx] != item {
            return false
        }
        return true
    }
}
