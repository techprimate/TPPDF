//
//  PDFTableCellPosition.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//

public struct PDFTableCellPosition: PDFJSONSerializable {
    
    public var row = -1
    public var column = -1
    
    public init(row: Int, column: Int) {
        self.row = row
        self.column = column
    }
}

extension PDFTableCellPosition: Hashable {

    /**
     Creates a hash value.

     Hash values are not guaranteed to be equal across different executions of
     your program. Do not save hash values to use during a future execution.
     */
    public var hashValue: Int {
        return row * row + column
    }
}

/**
 Returns a Boolean value indicating whether two values are equal.

 Equality is the inverse of inequality. For any values `a` and `b`,
 `a == b` implies that `a != b` is `false`.

 - Parameters:
   - lhs: A value to compare.
   - rhs: Another value to compare.
 */
public func == (lhs: PDFTableCellPosition, rhs: PDFTableCellPosition) -> Bool {
    return lhs.row == rhs.row && lhs.column == rhs.column
}
