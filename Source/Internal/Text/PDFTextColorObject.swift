//
//  PDFTextColorObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

/**
 Changes the text color in the container, where this object is in.
 */
internal class PDFTextColorObject: PDFRenderObject {

    /**
     New text color in container after calculation
     */
    internal var color: UIColor

    /**
     Initalizer

     - parameter textColor: New text color
     */
    internal init(color: UIColor) {
        self.color = color
    }

    /**
     Sets the text color in `container`

     - parameter generator: Generator which holds font information
     - parameter container: Container, where the font is changed

     - throws: None

     - returns: Self
     */
    override internal func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFRenderObject)] {
        generator.textColor[container] = color

        return [(container, self)]
    }

    /**
     Creates a new `PDFTextColorObject` with the same properties
     */
    override internal var copy: PDFRenderObject {
        return PDFTextColorObject(color: self.color)
    }
}
