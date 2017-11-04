//
//  PDFPageLayout+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 04/11/2017.
//

extension PDFPageLayout: Equatable {

    public static func == (lhs: PDFPageLayout, rhs: PDFPageLayout) -> Bool {
        return lhs.size == rhs.size
            && lhs.margin == rhs.margin
            && lhs.space == rhs.space
    }
}
