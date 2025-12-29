//
//  PDFIndentationObject+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.14.2017.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
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
