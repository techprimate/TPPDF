//
//  PDFPageLayout+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.04.2017.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
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
