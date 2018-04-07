//
//  PDFOffsetObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

/**
 Used to modify the offset of a container
 */
class PDFOffsetObject: PDFObject {

    /**
     Offset from top edge of container
     */
    var offset: CGFloat

    /**
     Initializer with point offset

     - parameter offset: Points from the top edge of the container
     */
    init(offset: CGFloat) {
        self.offset = offset
    }

    /**
     Modifies the layout of the given `generator`.

     - parameter generator: Generator which uses this object
     - parameter container: Container where this object is located

     - returns: Self
     */
    @discardableResult
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFObject)] {
        generator.layout.setContentOffset(in: container, to: offset)

        return [(container, self)]
    }

    override var copy: PDFObject {
        return PDFOffsetObject(offset: self.offset)
    }
}
