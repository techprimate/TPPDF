//
//  PDFList+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

// swiftlint:disable for_where

extension PDFList: Equatable {

    public static func == (lhs: PDFList, rhs: PDFList) -> Bool {
        if lhs.levelIndentations.count != rhs.levelIndentations.count {
            return false
        }

        for (idx, indentation) in lhs.levelIndentations.enumerated() {
            if rhs.levelIndentations[idx] != indentation {
                return false
            }
        }

        if lhs.items.count != rhs.items.count {
            return false
        }

        for (idx, item) in lhs.items.enumerated() {
            if rhs.items[idx] != item {
                return false
            }
        }

        return true
    }

}
