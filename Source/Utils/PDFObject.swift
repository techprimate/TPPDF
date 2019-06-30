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
public class PDFObject: CustomStringConvertible, PDFJSONSerializable {

    /**
     Frame of this object
     */
    internal var frame: CGRect = CGRect.null

    /**
     Calculates the object and returns all calculated objects which are created by this calculated.

     - parameter generator:
     - parameter container:

     - throws: PDFError

     - returns: List of objects and the container they are located in
     */
    @discardableResult
    internal func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFObject)] {
        return []
    }

    /**
     Draws the object into the current graphics context.

     - parameter generator: Unused
     - parameter container: Unused

     - throws: None
     */
    internal func draw(generator: PDFGenerator, container: PDFContainer) throws {}

    /**
     TODO: Documentation
     */
    internal var copy: PDFObject {
        fatalError()
    }
}
