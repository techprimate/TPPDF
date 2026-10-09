//
//  PDFOffsetObject+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.14.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
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
