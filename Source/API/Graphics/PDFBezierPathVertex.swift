//
//  PDFBezierPathVertex.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 01.06.19.
//

#if os(iOS) || os(visionOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

/// A vertex in a ``PDFBezierPath``
public class PDFBezierPathVertex: CustomStringConvertible {
    /// Anchor used to define the handling of scaling a ``PDFBezierPath``
    public enum Anchor {
        /// Keep distance to top and left edges of frame
        case topLeft

        /// Keep distance to top and horizontal center edges of frame
        case topCenter

        /// Keep distance to top and right edges of frame
        case topRight

        /// Keep distance to vertical middle and left edges of frame
        case middleLeft

        /// Keep distance to center of frame
        case middleCenter

        /// Keep distance to vertical middle and right edges of frame
        case middleRight

        /// Keep distance to bottom and left edges of frame
        case bottomLeft

        /// Keep distance to bottom edge and horizontal of frame
        case bottomCenter

        /// Keep distance to bottom and right edges of frame
        case bottomRight
    }

    /// Position of the vertex, relative to the ``PDFBezierPath`` using this vertex.
    public var position: CGPoint

    /**
     * Anchor used modify the position during scaling
     *
     * See ``PDFBezierPath`` for details.
     */
    public var anchor: Anchor

    /**
     * Creates a new instance of a bezier path to be used with ``PDFDynamicGeometryShape`` to render complex but dynamic shapes
     *
     * - Parameters:
     *   - position: See ``PDFBezierPathVertex/position``
     *   - anchor: See ``PDFBezierPathVertex/anchor``
     */
    public init(position: CGPoint, anchor: Anchor) {
        self.position = position
        self.anchor = anchor
    }
}
