//
//  PDFSimpleText.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 31/10/2017.
//

/**
 Text and spacing of a text object.

 Use this class for simple and quick text drawing
 */
public class PDFSimpleText: PDFText {

    /**
     Text to be drawn
     */
    public var text: String

    /**
     Line spacing if multiple lines
     */
    public var spacing: CGFloat

    /**
     Initalizer

     - parameter text: Text to be drawn
     - parameter spacing: Spacing between text lines, defaults to 0
     */
    public init(text: String, spacing: CGFloat = 0) {
        self.text = text
        self.spacing = spacing
    }

    override var copy: PDFText {
        return PDFSimpleText(text: self.text, spacing: self.spacing)
    }
}

extension PDFSimpleText: PDFJSONSerializable {}
