//
//  PDFSingleDocumentGenerator+Layout.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/**
 Extends the generator with shorthand methods for accessing and modifying the layout
 */
extension PDFGenerator {

    /**
     Get content offset of the given `container`

     - parameter container: Container where the offset is requested

     - returns: Offset in points
     */
    internal func getContentOffset(in container: PDFContainer) -> CGFloat {
        layout.getContentOffset(in: container)
    }

    /**
     Set a content offset to a value of a given container

     - parameter container: Container where the offset is set
     - parameter value: Offset value
     */
    internal func setContentOffset(in container: PDFContainer, to value: CGFloat) {
        layout.setContentOffset(in: container, to: value)
    }

}
