//
//  PDFTableCell+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

extension PDFTableCell: Equatable {

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
