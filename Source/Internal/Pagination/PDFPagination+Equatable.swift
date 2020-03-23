//
//  PDFPagination+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 04/11/2017.
//

/**
 TODO: Documentation
 */
extension PDFPagination: Equatable {

    /**
     TODO: Documentation
     */
    public static func == (lhs: PDFPagination, rhs: PDFPagination) -> Bool {
        guard lhs.container == rhs.container else {
            return false
        }
        guard lhs.style == rhs.style else {
            return false
        }
        guard lhs.range == rhs.range else {
            return false
        }
        guard lhs.hiddenPages == rhs.hiddenPages else {
            return false
        }
        return true
    }
}
