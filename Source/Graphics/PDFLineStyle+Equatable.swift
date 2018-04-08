//
//  PDFLineStyle+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

extension PDFLineStyle: Equatable {

    public static func == (lhs: PDFLineStyle, rhs: PDFLineStyle) -> Bool {
        if lhs.type != rhs.type {
            return false
        }

        if lhs.color != rhs.color {
            return false
        }

        if lhs.width != rhs.width {
            return false
        }

        return true
    }

}
