//
//  PDFSpaceObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

/**
 Empty space between two elements
 */
class PDFSpaceObject: PDFObject {

    /**
     Height of space object in points
     */
    var space: CGFloat

    /**
     Initializer

     - parameter space: Height of space object
     */
    init(space: CGFloat) {
        self.space = space
    }

    /**
     Creates a spacing object in the given `generator` in the given `container`

     - parameter generator: Generator which uses this object
     - parameter container: Container where this object is in

     - throws: None

     - returns: Self
     */
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFObject)] {
        let document = generator.document

        let expectedY = document.layout.margin.bottom
            + generator.layout.heights.maxHeaderHeight()
            + document.layout.space.header
            + generator.layout.heights.content
        let maxY = document.layout.margin.top
            + generator.layout.heights.maxHeaderHeight()
            + document.layout.space.header
            + document.layout.contentSize.height
        let origin = CGPoint(
            x: document.layout.margin.left
                + generator.layout.indentation.leftIn(container: container),
            y: expectedY > maxY ? maxY : expectedY)

        let width = document.layout.size.width
            - document.layout.margin.left
            - generator.layout.indentation.leftIn(container: container)
            - generator.layout.indentation.rightIn(container: container)
            - document.layout.margin.right
        let height = min(space, maxY - origin.y)
        self.frame = CGRect(x: origin.x, y: origin.y, width: width, height: height)

        generator.layout.heights.add(height, to: container)

        return [(container, self)]
    }

    /**
     If `generator.debug` is enabled, this will draw a green rectangle with red border into the current context.

     - parameter generator: Unused
     - parameter container: Unused

     - throws: None
     */
    override func draw(generator: PDFGenerator, container: PDFContainer) throws {
        if generator.debug {
            PDFGraphics.drawRect(rect: self.frame, outline: PDFLineStyle(type: .dashed, color: .red, width: 1.0),
                                 pattern: PDFGraphics.FillPattern.dotted(foreColor: .green, backColor: .white))
        }
    }

    override var copy: PDFObject {
        return PDFSpaceObject(space: self.space)
    }
}
