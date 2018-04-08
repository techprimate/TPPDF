//
//  PDFTableCellPosition+Equatable-Hashable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

extension PDFTableCellPosition: Hashable {

    /**
     Creates a hash value.

     Hash values are not guaranteed to be equal across different executions of
     your program. Do not save hash values to use during a future execution.
     */
    public var hashValue: Int {
        return row * row * 10 + column
    }

}

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
        if lhs.row != rhs.row {
            return false
        }

        if lhs.column != rhs.column {
            return false
        }

        return true
    }

}
