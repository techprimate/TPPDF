//
//  PDFMasterGroup.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 31.05.19.
//

#if os(iOS) || os(visionOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

/**
 * Subclass of ``PDFGroup`` with additional properties to configure page background content
 *
 * Each instance of ``PDFDocument`` can have one group set as the ``PDFDocument/masterGroup`
 */
public class PDFMasterGroup: PDFGroup {
    /// Flag if `true`, the render frame of the group is the as large as the page allows, otherwise only as large as its content objects
    public var isFullPage: Bool

    /**
     * Creates a new master group with default values
     *
     * - Parameter isFullPage: See ``PDFMasterGroup/isFullPage`` for details
     */
    public init(isFullPage: Bool = false) {
        self.isFullPage = isFullPage
        super.init(allowsBreaks: false)
    }

    /**
     * Configures the space between the group and the edges of the page.
     *
     * - Parameters:
     *     - left: Space to left page edge
     *     - right: Space to right page edge
     *     - top: Space to top page edge
     *     - bottom: Space to bottom page edge
     */
    public func setMargin(left: CGFloat? = nil, right: CGFloat? = nil, top: CGFloat? = nil, bottom: CGFloat? = nil) {
        objects += [(.none, PDFMarginObject(left: left, right: right, top: top, bottom: bottom))]
    }

    /// Resets the margin of the group to the margin of the ``PDFDocument/layout``
    public func resetMargin() {
        objects += [(.none, PDFMarginObject(reset: true))]
    }
}
