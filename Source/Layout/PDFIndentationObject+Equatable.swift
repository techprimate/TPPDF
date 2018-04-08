//
//  PDFIndentationObject+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 14/11/2017.
//

extension PDFIndentationObject: Equatable {

    public static func == (lhs: PDFIndentationObject, rhs: PDFIndentationObject) -> Bool {
        if lhs.indentation != rhs.indentation {
            return false
        }

        if lhs.left != rhs.left {
            return false
        }

        return true
    }

}
