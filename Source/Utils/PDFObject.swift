//
//  PDFObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

/**
 All renderable objects subclass from this object.
 Each object is first calculated and then drawn.
 */
class PDFObject: PDFJSONSerializable {

    /**
     Frame of this object
     */
    var frame: CGRect = .zero

    /**
     Calculates the object and returns all calculated objects which are created by this calculated.

     - parameter generator:
     - parameter container:

     - throws: PDFError

     - returns: List of objects and the container they are located in
     */
    @discardableResult
    func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFObject)] {
        return []
    }

    /**
     Draws the object into the current graphics context.

     - parameter generator: Unused
     - parameter container: Unused

     - throws: None
     */
    func draw(generator: PDFGenerator, container: PDFContainer) throws {}

    var copy: PDFObject {
        fatalError()
    }
}
