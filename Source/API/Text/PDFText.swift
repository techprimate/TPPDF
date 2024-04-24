//
//  PDFText.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 31/10/2017.
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
