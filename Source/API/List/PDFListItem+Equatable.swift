//
//  PDFListItem+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

/**
 TODO: documentation
 */
extension PDFListItem: Equatable {

    /**
     TODO: documentation
     */
    public static func == (lhs: PDFListItem, rhs: PDFListItem) -> Bool {
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
