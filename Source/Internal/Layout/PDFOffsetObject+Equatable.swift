//
//  PDFOffsetObject+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 14/11/2017.
//

extension PDFOffsetObject: Equatable {
    /// nodoc
    public static func == (lhs: PDFOffsetObject, rhs: PDFOffsetObject) -> Bool {
        guard lhs.offset == rhs.offset else {
            return false
        }
        return true
    }
}
