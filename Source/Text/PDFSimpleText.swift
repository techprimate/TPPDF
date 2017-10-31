//
//  PDFSimpleText.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 31/10/2017.
//

public class PDFSimpleText: PDFText, TPJSONSerializable {
    
    public var text: String
    public var spacing: CGFloat
    
    public init(text: String, spacing: CGFloat = 0) {
        self.text = text
        self.spacing = spacing
    }
}
