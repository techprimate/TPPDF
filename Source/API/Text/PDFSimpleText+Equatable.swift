//
//  PDFSimpleText+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

/**
 TODO: Documentation
 */
extension PDFSimpleText {

    public static func == (lhs: PDFSimpleText, rhs: PDFSimpleText) -> Bool {
        // Properties of PDFObjectAttribute
        guard lhs.attributes == rhs.attributes else {
            return false
        }
        guard lhs.tag == rhs.tag else {
            return false
        }
        // Properties of PDFSimpleText
        guard lhs.text == rhs.text else {
            return false
        }
        guard lhs.spacing == rhs.spacing else {
            return false
        }
        return true
    }
}
