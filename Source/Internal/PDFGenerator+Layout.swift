//
//  PDFGenerator+Layout.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//

#if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
    import UIKit
#else
    import AppKit
#endif

/**
 * Extends the generator with shorthand methods for accessing and modifying the layout
 */
extension PDFGenerator {
    /**
     * Get content offset of the given `container`
     *
     * - Parameter container: Container where the offset is requested
     *
     * - Returns: Offset in points
     */
    func getContentOffset(in container: PDFContainer) -> CGFloat {
        layout.getContentOffset(in: container)
    }

    /**
     * Set a content offset to a value of a given container
     *
     * - Parameter container: Container where the offset is set
     * - Parameter value: Offset value
     */
    func setContentOffset(in container: PDFContainer, to value: CGFloat) {
        layout.setContentOffset(in: container, to: value)
    }
}
