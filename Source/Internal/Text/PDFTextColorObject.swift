//
//  PDFTextColorObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 08.12.2017.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
    import UIKit
#else
    import AppKit
#endif

/**
 Changes the text color in the container, where this object is in.
 */
class PDFTextColorObject: PDFRenderObject {
    /**
     New text color in container after calculation
     */
    var color: Color

    /**
     Initializer

     - Parameter textColor: New text color
     */
    init(color: Color) {
        self.color = color
    }

    /**
     Sets the text color in `container`

     - Parameter generator: Generator which holds font information
     - Parameter container: Container, where the font is changed

     - Throws: None

     - Returns: Self
     */
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [PDFLocatedRenderObject] {
        generator.textColor[container] = color

        return [(container, self)]
    }

    /**
     Creates a new `PDFTextColorObject` with the same properties
     */
    override var copy: PDFRenderObject {
        PDFTextColorObject(color: color)
    }
}
