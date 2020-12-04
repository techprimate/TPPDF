//
//  PDFTable+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

extension PDFTable {

    /// Compares two instances of `PDFTable` for equality
    ///
    /// - Parameters:
    ///   - lhs: One instance of `PDFTable`
    ///   - rhs: Another instance of `PDFTable`
    /// - Returns: `true`, if `attributes`, `tag`, `style`, `cells`, `widths`, `padding`, `margin`, `showHeadersOnEveryPage` equal; otherwise `false`
    public static func == (lhs: PDFTable, rhs: PDFTable) -> Bool {
        // Properties of PDFObjectAttribute
        guard lhs.attributes == rhs.attributes else {
            return false
        }
        guard lhs.tag == rhs.tag else {
            return false
        }
        // Properties of PDFTable
        guard lhs.style == rhs.style else {
            return false
        }
        guard lhs.cells.count == rhs.cells.count else {
            return false
        }
        for i in 0..<lhs.cells.count where lhs.cells[i] != rhs.cells[i] {
            return false
        }
        guard lhs.widths == rhs.widths else {
            return false
        }
        guard lhs.padding == rhs.padding else {
            return false
        }
        guard lhs.margin == rhs.margin else {
            return false
        }
        guard lhs.showHeadersOnEveryPage == rhs.showHeadersOnEveryPage else {
            return false
        }
        return true
    }

}
