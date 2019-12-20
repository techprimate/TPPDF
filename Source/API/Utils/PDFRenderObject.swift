//
//  PDFRenderObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

/**
 All renderable objects subclass from this object.
 Each object is first calculated and then drawn.
 */
public class PDFRenderObject: CustomStringConvertible, PDFJSONSerializable {

    /**
     Frame of this object
     */
    internal var frame: CGRect = CGRect.null

    /**
     Attributes set for this object, and their calculated frame
     */
    internal var attributes: [(attribute: PDFObjectAttribute, frame: CGRect)] = []

    /**
     Calculates the object and returns all calculated objects which are created by this calculated.

     - parameter generator:
     - parameter container:

     - throws: PDFError

     - returns: List of objects and the container they are located in
     */
    @discardableResult
    internal func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFRenderObject)] {
        return []
    }

    /**
     Draws the object into the current graphics context.

     - parameter generator: Unused
     - parameter container: Unused

     - throws: None
     */
    internal func draw(generator: PDFGenerator, container: PDFContainer) throws {
        applyAttributes()
    }

    /**
     TODO: Documentation
     */
    internal var copy: PDFRenderObject {
        fatalError()
    }

    /**
     Applies the attributes to the current render context.
     Should be called after calling `draw`
     */
    internal func applyAttributes() {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        for (attribute, frame) in attributes {
            switch attribute {
            case .link(let url):
                context.setURL(url as CFURL, for: frame.applying(context.userSpaceToDeviceSpaceTransform))
            }
        }
    }
}
