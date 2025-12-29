//
//  PDFLineSeparatorObject+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.12.2017.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

extension PDFLineSeparatorObject: Equatable {
    /// nodoc
    public static func == (lhs: PDFLineSeparatorObject, rhs: PDFLineSeparatorObject) -> Bool {
        guard lhs.style == rhs.style else {
            return false
        }
        return true
    }
}
