//
//  PDFLayoutHeights+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.12.2017.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

extension PDFLayoutHeights: Equatable {
    /// nodoc
    public static func == (lhs: PDFLayoutHeights, rhs: PDFLayoutHeights) -> Bool {
        guard lhs.header == rhs.header else {
            return false
        }
        guard lhs.content == rhs.content else {
            return false
        }
        guard lhs.footer == rhs.footer else {
            return false
        }
        return true
    }
}
