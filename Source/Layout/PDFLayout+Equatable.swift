//
//  PDFLayout+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

extension PDFLayout: Equatable {

    public static func == (lhs: PDFLayout, rhs: PDFLayout) -> Bool {
        if lhs.heights != rhs.heights {
            return false
        }

        if lhs.indentation != rhs.indentation {
            return false
        }

        return true
    }

}
