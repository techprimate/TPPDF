//
//  PDFTableCellStyle+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

extension PDFTableCellStyle: Equatable {

    public static func == (lhs: PDFTableCellStyle, rhs: PDFTableCellStyle) -> Bool {
        if lhs.colors != rhs.colors {
            return false
        }

        if lhs.borders != rhs.borders {
            return false
        }

        if lhs.font != rhs.font {
            return false
        }

        return true
    }

}
