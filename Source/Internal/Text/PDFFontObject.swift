//
//  PDFFontObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

#if os(iOS) || os(visionOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

/**
 Changes the font of the container, where this object is in.
 */
class PDFFontObject: PDFRenderObject {
    /**
     New font of container after calculation
     */
    var font: Font

    /**
     Initializer

     - Parameter font: New font
     */
    init(font: Font) {
        self.font = font
    }

    /**
     Sets the font in `container`

     - Parameter generator: Generator which holds font information
     - Parameter container: Container, where the font is changed

     - Throws: None

     - Returns: Self
     */
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [PDFLocatedRenderObject] {
        generator.fonts[container] = font

        return [(container, self)]
    }

    /**
     Creates a new `PDFFontObject` with the same properties
     */
    override var copy: PDFRenderObject {
        PDFFontObject(font: font)
    }
}
