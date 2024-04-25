//
//  PDFIndentationObject+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 14/11/2017.
//

extension PDFIndentationObject: Equatable {
    /// nodoc
    public static func == (lhs: PDFIndentationObject, rhs: PDFIndentationObject) -> Bool {
        guard lhs.indentation == rhs.indentation else {
            return false
        }
        guard lhs.left == rhs.left else {
            return false
        }
        guard lhs.insideSectionColumn == rhs.insideSectionColumn else {
            return false
        }
        return true
    }
}
