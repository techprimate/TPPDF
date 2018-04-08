//
//  PDFRectangleObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 06.12.17.
//

/**
 Calculates and draws a rectangle.

 Sqaure line is drawn between left and right indentation.
 */
class PDFRectangleObject: PDFObject {

    /**
     Defines the style of the outline
     */
    var lineStyle: PDFLineStyle

    /**
     Defines the size of the rectangle
     */
    var size: CGSize

    /**
     Defines the fill color the rectangle
     */
    var fillColor: UIColor

    /**
     Initializer

     - parameter lineStyle: Style of outline, defaults to `PDFLineStyle` defaults
     - parameter size: Size of rectangle, defaults to `CGSize.zero`
     - parameter fillColor: Fill color, defaults to `UIColor.clear`
     */
    init(lineStyle: PDFLineStyle = PDFLineStyle(), size: CGSize = CGSize.zero, fillColor: UIColor = UIColor.clear) {
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
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFObject)] {
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
    override func draw(generator: PDFGenerator, container: PDFContainer) throws {
        PDFGraphics.drawRect(rect: self.frame, outline: lineStyle, fill: fillColor)
    }

    override var copy: PDFObject {
        return PDFRectangleObject(lineStyle: self.lineStyle, size: self.size, fillColor: self.fillColor)
    }
}
