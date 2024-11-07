//
//  PDFRenderObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

#if os(iOS) || os(visionOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

/**
 * All renderable objects subclass from this object.
 *
 * Each object is first calculated and then drawn.
 */
public class PDFRenderObject: CustomStringConvertible {
    /// Frame of this object
    var frame: CGRect = .null

    ///  Attributes set for this object, and their calculated frame
    var attributes: [(attribute: PDFObjectAttribute, frame: CGRect)] = []
    
    init(frame: CGRect = .null, attributes: [(attribute: PDFObjectAttribute, frame: CGRect)] = []) {
        self.frame = frame
        self.attributes = attributes
    }

    /**
     * Calculates the object and returns all calculated objects which are created by this calculated.
     *
     * - Parameter generator:
     * - Parameter container:
     *
     * - Throws: PDFError
     *
     * - Returns: List of objects and the container they are located in
     */
    @discardableResult
    func calculate(generator _: PDFGenerator, container _: PDFContainer) throws -> [PDFLocatedRenderObject] {
        []
    }

    /**
     * Draws the object into the current graphics context.
     *
     * - Parameter generator: Unused
     * - Parameter container: Unused
     *
     * - Throws: None
     */
    func draw(generator _: PDFGenerator, container _: PDFContainer, in context: PDFContext) throws {
        applyAttributes(in: context)
    }

    /// nodoc
    var copy: PDFRenderObject {
        fatalError()
    }

    /**
     * Applies the attributes to the current render context.
     *
     * Should be called after calling `draw`
     */
    func applyAttributes(in context: PDFContext) {
        for (attribute, frame) in attributes {
            switch attribute {
            case let .link(url):
                context.setURL(url as CFURL, for: frame.applying(context.userSpaceToDeviceSpaceTransform))
            }
        }
    }
}
