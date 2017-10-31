//
//  PDFAttributedText.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 31/10/2017.
//

public class PDFAttributedText: PDFText, TPJSONSerializable {
    
    public var text: NSAttributedString
    
    public init(text: NSAttributedString) {
        self.text = text
    }
}
