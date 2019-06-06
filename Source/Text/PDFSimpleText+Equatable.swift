//
//  PDFSimpleText+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

/**
 TODO: Documentation
 */
extension PDFSimpleText: Equatable {

    /**
     TODO: Documentation
     */
    public static func == (lhs: PDFSimpleText, rhs: PDFSimpleText) -> Bool {
        guard lhs.text == rhs.text else {
            return false
        }
        guard lhs.spacing == rhs.spacing else {
            return false
        }
        return true
    }
}
