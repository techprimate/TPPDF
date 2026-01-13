//
//  PDFTableStyle+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.09.2017.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

extension PDFTableStyle: Equatable {
    /// nodoc
    public static func == (lhs: PDFTableStyle, rhs: PDFTableStyle) -> Bool {
        guard lhs.rowHeaderCount == rhs.rowHeaderCount else {
            return false
        }
        guard lhs.columnHeaderCount == rhs.columnHeaderCount else {
            return false
        }
        guard lhs.footerCount == rhs.footerCount else {
            return false
        }
        guard lhs.outline == rhs.outline else {
            return false
        }
        guard lhs.rowHeaderStyle == rhs.rowHeaderStyle else {
            return false
        }
        guard lhs.columnHeaderStyle == rhs.columnHeaderStyle else {
            return false
        }
        guard lhs.footerStyle == rhs.footerStyle else {
            return false
        }
        guard lhs.contentStyle == rhs.contentStyle else {
            return false
        }
        guard lhs.alternatingContentStyle == rhs.alternatingContentStyle else {
            return false
        }
        return true
    }
}
