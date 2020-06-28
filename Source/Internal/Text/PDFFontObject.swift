//
//  PDFFontObject.swift
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
 Changes the font of the container, where this object is in.
 */
internal class PDFFontObject: PDFRenderObject {

    /**
     New font of container after calculation
     */
    internal var font: Font

    /**
     Initalizer

     - parameter font: New font
     */
    internal init(font: Font) {
        self.font = font
    }

    /**
     Sets the font in `container`

     - parameter generator: Generator which holds font information
     - parameter container: Container, where the font is changed

     - throws: None

     - returns: Self
     */
    override internal func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [PDFLocatedRenderObject] {
        generator.fonts[container] = font

        return [(container, self)]
    }

    /**
     Creates a new `PDFFontObject` with the same properties
     */
    override internal var copy: PDFRenderObject {
        PDFFontObject(font: self.font)
    }
}
