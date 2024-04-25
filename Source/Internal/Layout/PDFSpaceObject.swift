//
//  PDFSpaceObject.swift
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
 Empty space between two elements
 */
class PDFSpaceObject: PDFRenderObject {
    /**
     Height of space object in points
     */
    var space: CGFloat

    /**
     Initializer

     - Parameter space: Height of space object
     */
    init(space: CGFloat) {
        self.space = space
    }

    /**
     Creates a spacing object in the given `generator` in the given `container`

     - Parameter generator: Generator which uses this object
     - Parameter container: Container where this object is in

     - Throws: None

     - Returns: Self
     */
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [PDFLocatedRenderObject] {
        var size = PDFCalculations.calculateAvailableFrame(for: generator, in: container)
        size.height = min(space, size.height)
        let position = PDFCalculations.calculateElementPosition(for: generator, in: container, with: frame.size)
        frame = CGRect(origin: position, size: size)
        generator.layout.heights.add(space, to: container)

        var result: [PDFLocatedRenderObject] = [(container, self)]
        if PDFCalculations.calculateAvailableFrameHeight(for: generator, in: container) <= 0 {
            result += try PDFPageBreakObject().calculate(generator: generator, container: container)
        }
        return result
    }

    /**
     If `generator.debug` is enabled, this will draw a green rectangle with red border into the current context.

     - Parameter generator: Unused
     - Parameter container: Unused

     - Throws: None
     */
    override func draw(generator: PDFGenerator, container _: PDFContainer, in context: PDFContext) throws {
        if generator.debug {
            PDFGraphics.drawRect(in: context,
                                 rect: frame,
                                 outline: PDFLineStyle(type: .dashed, color: .red, width: 1.0),
                                 pattern: PDFGraphics.FillPattern.dotted(foreColor: .green, backColor: .white))
        }
        applyAttributes(in: context)
    }

    /**
     Creates a new `PDFSpaceObject` with the same properties
     */
    override var copy: PDFRenderObject {
        PDFSpaceObject(space: space)
    }
}
