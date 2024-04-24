//
//  PDFPageLayout+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 04/11/2017.
//

extension PDFPageLayout: Equatable {
    /// nodoc
    public static func == (lhs: PDFPageLayout, rhs: PDFPageLayout) -> Bool {
        guard lhs.size == rhs.size else {
            return false
        }
        guard lhs.margin == rhs.margin else {
            return false
        }
        guard lhs.space == rhs.space else {
            return false
        }
        return true
    }
}
