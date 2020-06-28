//
//  PDFTextColorObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/**
 Changes the text color in the container, where this object is in.
 */
internal class PDFTextColorObject: PDFRenderObject {

    /**
     New text color in container after calculation
     */
    internal var color: Color

    /**
     Initalizer

     - parameter textColor: New text color
     */
    internal init(color: Color) {
        self.color = color
    }

    /**
     Sets the text color in `container`

     - parameter generator: Generator which holds font information
     - parameter container: Container, where the font is changed

     - throws: None

     - returns: Self
     */
    override internal func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [PDFLocatedRenderObject] {
        generator.textColor[container] = color

        return [(container, self)]
    }

    /**
     Creates a new `PDFTextColorObject` with the same properties
     */
    override internal var copy: PDFRenderObject {
        PDFTextColorObject(color: self.color)
    }
}
