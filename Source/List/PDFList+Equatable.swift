//
//  PDFList+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

/**
 TODO: documentation
 */
extension PDFList: Equatable {

    /**
     TODO: documentation
     */
    public static func == (lhs: PDFList, rhs: PDFList) -> Bool {
        guard lhs.levelIndentations.count == rhs.levelIndentations.count else {
            return false
        }
        for (idx, indentation) in lhs.levelIndentations.enumerated() where rhs.levelIndentations[idx] != indentation {
            return false
        }
        guard lhs.items.count == rhs.items.count else {
            return false
        }
        for (idx, item) in lhs.items.enumerated() where rhs.items[idx] != item {
            return false
        }
        return true
    }
}
