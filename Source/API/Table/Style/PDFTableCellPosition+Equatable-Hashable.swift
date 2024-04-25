//
//  PDFTableCellPosition+Equatable-Hashable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

import Foundation

// MARK: - PDFTableCellPosition + Hashable

extension PDFTableCellPosition: Hashable {
    /// Creates a hash value of the cell position
    public func hash(into hasher: inout Hasher) {
        hasher.combine(row)
        hasher.combine(column)
    }
}

// MARK: - PDFTableCellPosition + Equatable

extension PDFTableCellPosition: Equatable {
    /// nodoc
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
