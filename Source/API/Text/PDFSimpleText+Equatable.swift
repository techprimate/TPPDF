//
//  PDFSimpleText+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

public extension PDFSimpleText {
    /// nodoc
    static func == (lhs: PDFSimpleText, rhs: PDFSimpleText) -> Bool {
        lhs.isEqual(to: rhs)
    }
}
