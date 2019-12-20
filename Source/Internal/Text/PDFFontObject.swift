//
//  PDFFontObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

/**
 Changes the font of the container, where this object is in.
 */
internal class PDFFontObject: PDFRenderObject {

    /**
     New font of container after calculation
     */
    internal var font: UIFont

    /**
     Initalizer

     - parameter font: New font
     */
    internal init(font: UIFont) {
        self.font = font
    }

    /**
     Sets the font in `container`

     - parameter generator: Generator which holds font information
     - parameter container: Container, where the font is changed

     - throws: None

     - returns: Self
     */
    override internal func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFRenderObject)] {
        generator.fonts[container] = font

        return [(container, self)]
    }

    /**
     Creates a new `PDFFontObject` with the same properties
     */
    override internal var copy: PDFRenderObject {
        return PDFFontObject(font: self.font)
    }
}
