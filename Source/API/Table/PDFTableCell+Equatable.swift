//
//  PDFTableCell+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

/**
 TODO: Documentation
 */
extension PDFTableCell: Equatable {

    /**
     TODO: Documentation
     */
    public static func == (lhs: PDFTableCell, rhs: PDFTableCell) -> Bool {
        if lhs.content != rhs.content {
            return false
        }
        if lhs.alignment != rhs.alignment {
            return false
        }
        if lhs.style != rhs.style {
            return false
        }
        return true
    }

}
