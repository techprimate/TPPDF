//
//  PDFListItem+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

extension PDFListItem: Equatable {

    public static func == (lhs: PDFListItem, rhs: PDFListItem) -> Bool {
        if lhs.parent !== rhs.parent {
            return false
        }

        if lhs.content != rhs.content {
            return false
        }

        if (lhs.children ?? []) != (rhs.children ?? []) {
            return false
        }

        if lhs.symbol != rhs.symbol {
            return false
        }

        return true
    }

}
