//
//  PDFLineStyle.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//

#if os(iOS) || os(visionOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

/// Structure defining how a line should be drawn into graphics context
public struct PDFLineStyle: Hashable {
    /// Type of the line
    public var type: PDFLineType

    /// Color of the line
    public var color: Color

    /// Width of the line
    public var width: CGFloat

    /// Defines the width of this radius (Only for rect draw, not for line)
    public var radius: CGFloat?

    /**
     * Initialize a table line style
     *
     * - Parameters:
     *    - type: See ``PDFLineStyle/type``
     *    - color: See ``PDFLineStyle/color``
     *    - width: See ``PDFLineStyle/width``
     *    - radius: See ``PDFLineStyle/radius``
     */
    public init(type: PDFLineType = .full, color: Color = .black, width: CGFloat = 0.25, radius: CGFloat? = nil) {
        self.type = type
        self.color = color
        self.width = width
        self.radius = radius
    }

    // MARK: - Equatable

    /// nodoc
    public static func == (lhs: PDFLineStyle, rhs: PDFLineStyle) -> Bool {
        guard lhs.type == rhs.type else { return false }
        guard lhs.color == rhs.color else { return false }
        guard lhs.width == rhs.width else { return false }
        return true
    }

    // MARK: - Hashable

    /// nodoc
    public func hash(into hasher: inout Hasher) {
        hasher.combine(type)
        hasher.combine(color)
        hasher.combine(width)
    }
}

// MARK: - Defaults

public extension PDFLineStyle {
    /// Shorthand method for creating an invisible line
    static var none: PDFLineStyle {
        PDFLineStyle(type: .none, width: 0)
    }
}
