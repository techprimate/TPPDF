//
//  PDFPageLayout+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 04/11/2017.
//

extension PDFPageLayout: Equatable {

    public static func == (lhs: PDFPageLayout, rhs: PDFPageLayout) -> Bool {
        if lhs.size != rhs.size {
            return false
        }

        if lhs.margin != rhs.margin {
            return false
        }

        if lhs.space != rhs.space {
            return false
        }

        return true
    }

}
