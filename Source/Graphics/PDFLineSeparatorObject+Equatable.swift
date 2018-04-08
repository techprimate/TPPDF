//
//  PDFLineSeparatorObject+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/11/2017.
//

extension PDFLineSeparatorObject: Equatable {

    public static func == (lhs: PDFLineSeparatorObject, rhs: PDFLineSeparatorObject) -> Bool {
        if lhs.style != rhs.style {
            return false
        }

        return true
    }

}
