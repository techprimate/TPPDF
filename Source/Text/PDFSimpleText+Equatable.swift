//
//  PDFSimpleText+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

extension PDFSimpleText: Equatable {

    public static func == (lhs: PDFSimpleText, rhs: PDFSimpleText) -> Bool {
        if lhs.text != rhs.text {
            return false
        }

        if lhs.spacing != rhs.spacing {
            return false
        }

        return true
    }

}
