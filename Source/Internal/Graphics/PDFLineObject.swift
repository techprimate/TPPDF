//
//  PDFLineObject.swift
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
 Calculates and draws a line.

 Line is drawn from startPoint and endPoint.
 */
class PDFLineObject: PDFRenderObject {
    /**
     Defines the style of the line
     */
    var style: PDFLineStyle

    /**
     Starting point of line
     */
    var startPoint: CGPoint

    /**
     Ending point of line
     */
    var endPoint: CGPoint

    /**
     Initializer

     - Parameter style: Style of line, defaults to `PDFLineStyle` defaults
     */
    init(style: PDFLineStyle = PDFLineStyle(), startPoint: CGPoint = CGPoint.zero, endPoint: CGPoint = CGPoint.zero) {
        self.style = style
        self.startPoint = startPoint
        self.endPoint = endPoint
    }

    /**
     Calculates the line start and end point

     - Parameter generator: Generator which uses this object
     - Parameter container: Container where the line is set

     - Throws: None

     - Returns: Self
     */
    override func calculate(generator _: PDFGenerator, container: PDFContainer) throws -> [PDFLocatedRenderObject] {
        let origin = CGPoint(x: min(startPoint.x, endPoint.x),
                             y: min(startPoint.y, endPoint.y))
        let size = CGSize(width: max(startPoint.x, endPoint.x) - origin.x,
                          height: max(startPoint.y, endPoint.y) - origin.y)

        frame = CGRect(origin: origin, size: size)

        return [(container, self)]
    }

    /**
     Draws the line in the calculated frame

     - Parameter generator: Unused
     - Parameter container: unused

     - Throws: None
     */
    override func draw(generator: PDFGenerator, container _: PDFContainer, in context: PDFContext) throws {
        PDFGraphics.drawLine(
            in: context,
            start: startPoint,
            end: endPoint,
            style: style
        )

        if generator.debug && (style.type == .none) {
            PDFGraphics.drawRect(in: context,
                                 rect: frame,
                                 outline: PDFLineStyle(type: .full, color: .red, width: 1.0),
                                 fill: .clear)
        }
        applyAttributes(in: context)
    }

    /**
     Creates a copy of this `PDFLineObject` with the same properties
     */
    override var copy: PDFRenderObject {
        PDFLineObject(style: style, startPoint: startPoint, endPoint: endPoint)
    }
}
