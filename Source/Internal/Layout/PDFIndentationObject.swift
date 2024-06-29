//
//  PDFIndentationObject.swift
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
 Used to modify the indentation of a container
 */
class PDFIndentationObject: PDFRenderObject {
    /**
     Offset from edge of container
     */
    var indentation: CGFloat

    /**
     Offset is from left edge if `true`, right if `false`
     */
    var left: Bool

    /**
     Flag to check if section inset inside column needs to be changed.
     If `true`, the indention is relative to the column left guide
     */
    var insideSectionColumn: Bool

    /**
     Initializer

     - Parameter indentation: Offset in points from edge
     - Parameter left: Offset is from left side if `true`, from right if `false`
     */
    init(indentation: CGFloat, left: Bool, insideSectionColumn: Bool) {
        self.indentation = indentation
        self.left = left
        self.insideSectionColumn = insideSectionColumn
    }

    /**
     Modifies the indentation of the given `generator` in the given `container`

     - Parameter generator: Generator which uses this object
     - Parameter container: Container where the indentation will change

     - Throws: None

     - Returns: Self
     */
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [PDFLocatedRenderObject] {
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
    override var copy: PDFRenderObject {
        PDFIndentationObject(indentation: indentation, left: left, insideSectionColumn: insideSectionColumn)
    }
}
