//
//  PDFLineSeparatorObject+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/11/2017.
//

extension PDFLineSeparatorObject: Equatable {

    /**
     TODO: Documentation
     */
    public static func == (lhs: PDFLineSeparatorObject, rhs: PDFLineSeparatorObject) -> Bool {
        guard lhs.style == rhs.style else {
            return false
        }
        return true
    }

}
