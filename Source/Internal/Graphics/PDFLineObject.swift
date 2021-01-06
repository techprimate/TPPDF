//
//  PDFLineObject.swift
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
 Calculates and draws a line.

 Line is drawn from startPoint and endPoint.
 */
internal class PDFLineObject: PDFRenderObject {

    /**
     Defines the style of the line
     */
    internal var style: PDFLineStyle

    /**
     Starting point of line
     */
    internal var startPoint: CGPoint

    /**
     Ending point of line
     */
    internal var endPoint: CGPoint

    /**
     Initializer

     - parameter style: Style of line, defaults to `PDFLineStyle` defaults
     */
    internal init(style: PDFLineStyle = PDFLineStyle(), startPoint: CGPoint = CGPoint.zero, endPoint: CGPoint = CGPoint.zero) {
        self.style = style
        self.startPoint = startPoint
        self.endPoint = endPoint
    }

    /**
     Calculates the line start and end point

     - parameter generator: Generator which uses this object
     - parameter container: Container where the line is set

     - throws: None

     - returns: Self
     */
    override internal func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [PDFLocatedRenderObject] {
        let origin = CGPoint(x: min(startPoint.x, endPoint.x),
                             y: min(startPoint.y, endPoint.y))
        let size = CGSize(width: max(startPoint.x, endPoint.x) - origin.x,
                          height: max(startPoint.y, endPoint.y) - origin.y)

        self.frame = CGRect(origin: origin, size: size)

        return [(container, self)]
    }

    /**
     Draws the line in the calculated frame

     - parameter generator: Unused
     - parameter container: unused

     - throws: None
     */
    override internal func draw(generator: PDFGenerator, container: PDFContainer, in context: PDFContext) throws {
        PDFGraphics.drawLine(
            in: context,
            start: startPoint,
            end: endPoint,
            style: style)

        if generator.debug && (style.type == .none) {
            PDFGraphics.drawRect(in: context,
                                 rect: self.frame,
                                 outline: PDFLineStyle(type: .full, color: .red, width: 1.0),
                                 fill: .clear)
        }
        applyAttributes(in: context)
    }

    /**
     Creates a copy of this `PDFLineObject` with the same properties
     */
    override internal var copy: PDFRenderObject {
        PDFLineObject(style: self.style, startPoint: self.startPoint, endPoint: self.endPoint)
    }
}
