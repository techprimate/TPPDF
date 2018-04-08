//
//  PDFLayoutIndentations+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/11/2017.
//

extension PDFLayoutIndentations: Equatable {

    public static func == (lhs: PDFLayoutIndentations, rhs: PDFLayoutIndentations) -> Bool {
        if lhs.header != rhs.header {
            return false
        }

        if lhs.content != rhs.content {
            return false
        }

        if lhs.footer != rhs.footer {
            return false
        }

        return true
    }

}
