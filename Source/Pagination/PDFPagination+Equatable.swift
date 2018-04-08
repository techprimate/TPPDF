//
//  PDFPagination+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 04/11/2017.
//

extension PDFPagination: Equatable {

    public static func == (lhs: PDFPagination, rhs: PDFPagination) -> Bool {
        return lhs.container == rhs.container
            && lhs.style == rhs.style
            && lhs.range == rhs.range
            && lhs.hiddenPages == rhs.hiddenPages
    }

}
