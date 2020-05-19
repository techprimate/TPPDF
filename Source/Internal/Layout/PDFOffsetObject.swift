//
//  PDFOffsetObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/**
 Used to modify the offset of a container
 */
internal class PDFOffsetObject: PDFRenderObject {

    /**
     Offset from top edge of container
     */
    internal var offset: CGFloat

    /**
     Initializer with point offset

     - parameter offset: Points from the top edge of the container
     */
    internal init(offset: CGFloat) {
        self.offset = offset
    }

    /**
     Modifies the layout of the given `generator`.

     - parameter generator: Generator which uses this object
     - parameter container: Container where this object is located

     - returns: Self
     */
    @discardableResult
    override internal func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [PDFLocatedRenderObject] {
        generator.layout.setContentOffset(in: container, to: offset)

        return [(container, self)]
    }

    /**
     Creates a news `PDFOffsetObject` with the same properties
     */
    override internal var copy: PDFRenderObject {
        PDFOffsetObject(offset: self.offset)
    }
}
