//
//  PDFIndentationObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

/**
 Used to modify the indentation of a container
 */
class PDFIndentationObject: PDFObject {

    /**
     Offset from edge of container
     */
    var indentation: CGFloat

    /**
     Offset is from left edge if `true`, right if `false`
     */
    var left: Bool

    /**
     Initializer

     - parameter indentation: Offset in points from edge
     - parameter left: Offset is from left side if `true`, from right if `false`
     */
    init(indentation: CGFloat, left: Bool) {
        self.indentation = indentation
        self.left = left
    }

    /**
     Modifies the indentation of the given `generator` in the given `container`

     - parameter generator: Generator which uses this object
     - parameter container: Container where the indentation will change

     - throws: None

     - returns: Self
     */
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFObject)] {
        if left {
            generator.layout.indentation.setLeft(indentation: indentation, in: container)
        } else {
            generator.layout.indentation.setRight(indentation: indentation, in: container)
        }

        return [(container, self)]
    }

    override var copy: PDFObject {
        return PDFIndentationObject(indentation: self.indentation, left: self.left)
    }
}
