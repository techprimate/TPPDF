//
//  PDFLayoutHeights+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/11/2017.
//

extension PDFLayoutHeights: Equatable {

    public static func == (lhs: PDFLayoutHeights, rhs: PDFLayoutHeights) -> Bool {
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
