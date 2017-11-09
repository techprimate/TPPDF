//
//  PDFTableContent+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

extension PDFTableContent: Equatable {

    public static func == (lhs: PDFTableContent, rhs: PDFTableContent) -> Bool {
        if lhs.type != rhs.type {
            return false
        }

        // FIXME: can't equate
        // if lhs.content != rhs.content {
        //    return false
        // }

        return true
    }
}

