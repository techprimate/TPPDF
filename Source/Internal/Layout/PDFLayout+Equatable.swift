//
//  PDFLayout+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.09.2017.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

extension PDFLayout: Equatable {
    /// nodoc
    public static func == (lhs: PDFLayout, rhs: PDFLayout) -> Bool {
        guard lhs.heights == rhs.heights else {
            return false
        }
        guard lhs.indentation == rhs.indentation else {
            return false
        }
        return true
    }
}
