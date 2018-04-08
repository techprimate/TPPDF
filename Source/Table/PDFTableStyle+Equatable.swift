//
//  PDFTableStyle+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

extension PDFTableStyle: Equatable {

    public static func == (lhs: PDFTableStyle, rhs: PDFTableStyle) -> Bool {
        if lhs.rowHeaderCount != rhs.rowHeaderCount {
            return false
        }

        if lhs.columnHeaderCount != rhs.columnHeaderCount {
            return false
        }

        if lhs.footerCount != rhs.footerCount {
            return false
        }

        if lhs.outline != rhs.outline {
            return false
        }

        if lhs.rowHeaderStyle != rhs.rowHeaderStyle {
            return false
        }

        if lhs.columnHeaderStyle != rhs.columnHeaderStyle {
            return false
        }

        if lhs.footerStyle != rhs.footerStyle {
            return false
        }

        if lhs.contentStyle != rhs.contentStyle {
            return false
        }

        if lhs.alternatingContentStyle != rhs.alternatingContentStyle {
            return false
        }

        return true
    }

}
