//
//  PDFOffsetObject+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 14/11/2017.
//

extension PDFOffsetObject: Equatable {

    public static func == (lhs: PDFOffsetObject, rhs: PDFOffsetObject) -> Bool {
        if lhs.offset != rhs.offset {
            return false
        }

        return true
    }

}
