//
//  PDFAttributedText+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

extension PDFAttributedText: Equatable {

    public static func == (lhs: PDFAttributedText, rhs: PDFAttributedText) -> Bool {
        if lhs.text != rhs.text {
            return false
        }

        return true
    }

}
