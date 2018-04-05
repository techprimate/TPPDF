//
//  PDFLineObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 06.12.17.
//

/**
 Calculates and draws a line.

 Line is drawn from startPoint and endPoint.
 */
class PDFLineObject: PDFObject {

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

     - parameter style: Style of line, defaults to `PDFLineStyle` defaults
     */
    init(style: PDFLineStyle = PDFLineStyle(), startPoint: CGPoint = CGPoint.zero, endPoint: CGPoint = CGPoint.zero) {
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
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFObject)] {
        let origin = CGPoint(x: min(startPoint.x, endPoint.x),
                             y: min(startPoint.x, endPoint.x))
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
    override func draw(generator: PDFGenerator, container: PDFContainer) throws {
        PDFGraphics.drawLine(
            start: startPoint,
            end: endPoint,
            style: style
        )

        if generator.debug && (style.type == .none) {
            PDFGraphics.drawRect(rect: self.frame, outline: PDFLineStyle(type: .full, color: .red, width: 1.0), fill: .clear)
        }
    }

    override var copy: PDFObject {
        return PDFLineObject(style: self.style, startPoint: self.startPoint, endPoint: self.endPoint)
    }
}
