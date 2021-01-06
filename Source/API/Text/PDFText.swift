//
//  PDFText.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 31/10/2017.
//

/// Protocol all text objects should implement
public class PDFText: PDFDocumentObject, CustomStringConvertible {

    var copy: PDFText {
        fatalError()
    }
}
