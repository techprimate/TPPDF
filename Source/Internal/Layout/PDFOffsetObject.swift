//
//  PDFOffsetObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 08.12.2017.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
    import UIKit
#else
    import AppKit
#endif

/**
 Used to modify the offset of a container
 */
class PDFOffsetObject: PDFRenderObject {
    /**
     Offset from top edge of container
     */
    var offset: CGFloat

    /**
     Initializer with point offset

     - Parameter offset: Points from the top edge of the container
     */
    init(offset: CGFloat) {
        self.offset = offset
    }

    /**
     Modifies the layout of the given `generator`.

     - Parameter generator: Generator which uses this object
     - Parameter container: Container where this object is located

     - Returns: Self
     */
    @discardableResult
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [PDFLocatedRenderObject] {
        generator.layout.setContentOffset(in: container, to: offset)

        return [(container, self)]
    }

    /**
     Creates a news `PDFOffsetObject` with the same properties
     */
    override var copy: PDFRenderObject {
        PDFOffsetObject(offset: offset)
    }
}
