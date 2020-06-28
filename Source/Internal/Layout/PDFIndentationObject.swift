//
//  PDFIndentationObject.swift
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
 Used to modify the indentation of a container
 */
internal class PDFIndentationObject: PDFRenderObject {

    /**
     Offset from edge of container
     */
    internal var indentation: CGFloat

    /**
     Offset is from left edge if `true`, right if `false`
     */
    internal var left: Bool

    /**
     Flag to check if section inset inside column needs to be changed.
     If `true`, the indention is relative to the column left guide
     */
    internal var insideSectionColumn: Bool

    /**
     Initializer

     - parameter indentation: Offset in points from edge
     - parameter left: Offset is from left side if `true`, from right if `false`
     */
    internal init(indentation: CGFloat, left: Bool, insideSectionColumn: Bool) {
        self.indentation = indentation
        self.left = left
        self.insideSectionColumn = insideSectionColumn
    }

    /**
     Modifies the indentation of the given `generator` in the given `container`

     - parameter generator: Generator which uses this object
     - parameter container: Container where the indentation will change

     - throws: None

     - returns: Self
     */
    override internal func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [PDFLocatedRenderObject] {
        var indent = indentation
        if left {
            if insideSectionColumn {
                indent += generator.layout.indentation.leftIn(container: container)
            }
            generator.layout.indentation.setLeft(indentation: indent, in: container)
        } else {
            if insideSectionColumn {
                indent += generator.layout.indentation.rightIn(container: container)
            }
            generator.layout.indentation.setRight(indentation: indent, in: container)
        }

        return [(container, self)]
    }

    /**
     Creates a new `PDFIndentationObject` with the same properties
     */
    override internal var copy: PDFRenderObject {
        PDFIndentationObject(indentation: self.indentation, left: self.left, insideSectionColumn: self.insideSectionColumn)
    }
}
