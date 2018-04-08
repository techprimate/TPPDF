//
//  PDFAttributedText.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 31/10/2017.
//

/**
 Attributed text objects hold an instance of `NSAttributedString`

 Use this class for advanced text drawing
 */
public class PDFAttributedText: PDFText {

    /**
     Text which will be drawn
     */
    public var text: NSAttributedString

    /**
     Initializer

     - parameter text: Text, which will be drawn
     */
    public init(text: NSAttributedString) {
        self.text = text
    }

    override var copy: PDFText {
        return PDFAttributedText(text: text)
    }
}

extension PDFAttributedText: PDFJSONSerializable {}
