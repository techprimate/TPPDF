//
//  PDFSimpleText+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.09.2017.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

public extension PDFSimpleText {
    /// nodoc
    static func == (lhs: PDFSimpleText, rhs: PDFSimpleText) -> Bool {
        lhs.isEqual(to: rhs)
    }
}
