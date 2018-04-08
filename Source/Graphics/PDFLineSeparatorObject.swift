//
//  PDFLineSeparator.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

/**
 Calculates and draws a horizontal separator line.

 Separator line is drawn between left and right indentation.
 */
class PDFLineSeparatorObject: PDFObject {

    /**
     Defines the style of the separator line
     */
    var style: PDFLineStyle

    /**
     Initializer

     - parameter style: Style of line, defaults to `PDFLineStyle` defaults
     */
    init(style: PDFLineStyle = PDFLineStyle()) {
        self.style = style
    }

    /**
     Calculates the line start and end point

     - parameter generator: Generator which uses this object
     - parameter container: Container where the line is set

     - throws: None

     - returns: Self
     */
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFObject)] {
        let x = generator.document.layout.margin.left
            + generator.layout.indentation.leftIn(container: container)
        let y = generator.layout.heights.maxHeaderHeight()
            + generator.document.layout.margin.top
            + generator.layout.heights.content

        let width = generator.document.layout.contentSize.width
            - generator.layout.indentation.leftIn(container: container)
            - generator.layout.indentation.rightIn(container: container)

        self.frame = CGRect(x: x, y: y, width: width, height: style.width)

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
            start: self.frame.origin,
            end: CGPoint(x: self.frame.maxX, y: self.frame.maxY),
            style: style
        )

        if generator.debug && (style.type == .none) {
            PDFGraphics.drawRect(rect: self.frame, outline: PDFLineStyle(type: .full, color: .red, width: 1.0), fill: .clear)
        }
    }

    override var copy: PDFObject {
        return PDFLineSeparatorObject(style: self.style)
    }
}
