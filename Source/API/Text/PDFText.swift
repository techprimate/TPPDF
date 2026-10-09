//
//  PDFText.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 10.31.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

/// Abstract class all text objects should implement
public class PDFText: PDFDocumentObject, CustomStringConvertible {
    /// Creates a new copy of this text
    ///
    /// - Note: Must be implemented by all subclasses
    public var copy: PDFText {
        fatalError("Not implemented")
    }
}
