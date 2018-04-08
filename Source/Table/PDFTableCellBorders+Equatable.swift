//
//  PDFTableCellBorders+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

extension PDFTableCellBorders: Equatable {

    public static func == (lhs: PDFTableCellBorders, rhs: PDFTableCellBorders) -> Bool {
        if lhs.left != rhs.left {
            return false
        }

        if lhs.top != rhs.top {
            return false
        }

        if lhs.right != rhs.right {
            return false
        }

        if lhs.bottom != rhs.bottom {
            return false
        }

        return true
    }

}
