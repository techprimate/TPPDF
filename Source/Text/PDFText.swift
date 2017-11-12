//
//  PDFText.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 31/10/2017.
//

/**
 Protocol all text objects should implement
 */
public class PDFText: Equatable {
    
}

public func == (lhs: PDFText, rhs: PDFText) -> Bool {
    if lhs is PDFAttributedText && rhs is PDFAttributedText {
        return (lhs as? PDFAttributedText) == (rhs as? PDFAttributedText)
    } else if lhs is PDFSimpleText && rhs is PDFSimpleText {
        return (lhs as? PDFSimpleText) == (rhs as? PDFSimpleText)
    }

    return false
}
