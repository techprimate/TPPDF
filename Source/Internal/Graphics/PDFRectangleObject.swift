//
//  PDFRectangleObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 06.12.17.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/**
 Calculates and draws a rectangle.

 Sqaure line is drawn between left and right indentation.
 */
internal class PDFRectangleObject: PDFRenderObject {

    /**
     Defines the style of the outline
     */
    internal var lineStyle: PDFLineStyle

    /**
     Defines the size of the rectangle
     */
    internal var size: CGSize

    /**
     Defines the fill color the rectangle
     */
    internal var fillColor: Color

    /**
     Initializer

     - parameter lineStyle: Style of outline, defaults to `PDFLineStyle` defaults
     - parameter size: Size of rectangle, defaults to `CGSize.zero`
     - parameter fillColor: Fill color, defaults to `Color.clear`
     */
    internal init(lineStyle: PDFLineStyle = PDFLineStyle(), size: CGSize = CGSize.zero, fillColor: Color = Color.clear) {
        self.lineStyle = lineStyle
        self.size = size
        self.fillColor = fillColor
    }

    /**
     Calculates the line start and end point

     - parameter generator: Generator which uses this object
     - parameter container: Container where the line is set

     - throws: None

     - returns: Self
     */
    override internal func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [PDFLocatedRenderObject] {
        let position = PDFCalculations.calculateElementPosition(for: generator, in: container, with: size)

        self.frame = CGRect(origin: position, size: size)

        return [(container, self)]
    }

    /**
     Draws the line in the calculated frame

     - parameter generator: Unused
     - parameter container: unused

     - throws: None
     */
    override internal func draw(generator: PDFGenerator, container: PDFContainer, in context: PDFContext) throws {
        PDFGraphics.drawRect(in: context, rect: self.frame, outline: lineStyle, fill: fillColor)
        applyAttributes(in: context)
    }

    /**
     Creates new `PDFRectangleObject` with the same properties
     */
    override internal var copy: PDFRenderObject {
        PDFRectangleObject(lineStyle: self.lineStyle, size: self.size, fillColor: self.fillColor)
    }
}
