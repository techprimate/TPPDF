//
//  PDFAttributedText+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

/**
 TODO: Documentation
 */
extension PDFAttributedText: Equatable {

    /**
     TODO: Documentation
     */
    public static func == (lhs: PDFAttributedText, rhs: PDFAttributedText) -> Bool {
        guard lhs.text == rhs.text else {
            return false
        }
        return true
    }
}
