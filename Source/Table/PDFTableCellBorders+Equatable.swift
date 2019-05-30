//
//  PDFTableCellBorders+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

/**
 TODO: Documentation
 */
extension PDFTableCellBorders: Equatable {

    /**
     TODO: Documentation
     */
    public static func == (lhs: PDFTableCellBorders, rhs: PDFTableCellBorders) -> Bool {
        guard lhs.left == rhs.left else {
            return false
        }
        guard lhs.top == rhs.top else {
            return false
        }
        guard lhs.right == rhs.right else {
            return false
        }
        guard lhs.bottom == rhs.bottom else {
            return false
        }
        return true
    }

}
