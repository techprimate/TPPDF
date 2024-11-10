//
//  PDFRectangleObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 06.12.17.
//

#if os(iOS) || os(visionOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

/**
 Calculates and draws a rectangle.

 Sqaure line is drawn between left and right indentation.
 */
class PDFRectangleObject: PDFRenderObject {
    /**
     Defines the style of the outline
     */
    var lineStyle: PDFLineStyle

    /**
     Defines the fill color the rectangle
     */
    var fillColor: Color

    /**
     Initializer

     - Parameter lineStyle: Style of outline, defaults to `PDFLineStyle` defaults
     - Parameter size: Size of rectangle, defaults to `CGSize.zero`
     - Parameter fillColor: Fill color, defaults to `Color.clear`
     */
    init(lineStyle: PDFLineStyle = PDFLineStyle(), frame: CGRect = CGRect.zero, fillColor: Color = Color.clear) {
        self.lineStyle = lineStyle
        self.fillColor = fillColor
        super.init(frame: frame)
    }

    /**
     Calculates the line start and end point

     - Parameter generator: Generator which uses this object
     - Parameter container: Container where the line is set

     - Throws: None

     - Returns: Self
     */
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [PDFLocatedRenderObject] {
        let position = PDFCalculations.calculateElementPosition(for: generator, in: container, with: frame.size)

        frame = CGRect(origin: position, size: frame.size)

        return [(container, self)]
    }

    /**
     Draws the line in the calculated frame

     - Parameter generator: Unused
     - Parameter container: unused

     - Throws: None
     */
    override func draw(generator _: PDFGenerator, container _: PDFContainer, in context: PDFContext) throws {
        PDFGraphics.drawRect(in: context, rect: frame, outline: lineStyle, fill: fillColor)
        applyAttributes(in: context)
    }

    /**
     Creates new `PDFRectangleObject` with the same properties
     */
    override var copy: PDFRenderObject {
        PDFRectangleObject(lineStyle: lineStyle, frame: frame, fillColor: fillColor)
    }
}
