//
//  PDFTableCellPosition+Equatable-Hashable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

import Foundation

/**
 TODO: Documentation
 */
extension PDFTableCellPosition: Hashable {

    /**
     Creates a hash value.

     Hash values are not guaranteed to be equal across different executions of
     your program. Do not save hash values to use during a future execution.
     */
    public func hash(into hasher: inout Hasher) {
        hasher.combine(row)
        hasher.combine(column)
    }
}

/**
 TODO: Documentation
 */
extension PDFTableCellPosition: Equatable {

    /**
     Returns a Boolean value indicating whether two values are equal.

     Equality is the inverse of inequality. For any values `a` and `b`,
     `a == b` implies that `a != b` is `false`.

     - Parameters:
     - lhs: A value to compare.
     - rhs: Another value to compare.
     */
    public static func == (lhs: PDFTableCellPosition, rhs: PDFTableCellPosition) -> Bool {
        guard lhs.row == rhs.row else {
            return false
        }
        guard lhs.column == rhs.column else {
            return false
        }
        return true
    }
}
