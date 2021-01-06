//
//  PDFLineStyle.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/**
 This struct defines how a line or border of a table is drawn.
 */
public struct PDFLineStyle: Hashable {

    /**
     Defines the type of this line
     */
    public var type: PDFLineType

    /**
     Defines the color of this line
     */
    public var color: Color

    /**
     Defines the width of this line
     */
    public var width: CGFloat

    /**
     Defines the width of this radius (Only for rect draw, not for line)
     */
    public var radius: CGFloat?

    /**
     Initialize a table line style

     - parameter type: of Line
     - parameter color: of Line
     - parameter width: of Line
     - parameter radius: of border
     */
    public init(type: PDFLineType = .full, color: Color = .black, width: CGFloat = 0.25, radius: CGFloat? = nil) {
        self.type = type
        self.color = color
        self.width = width
        self.radius = radius
    }

    // MARK: - Equatable

    public static func == (lhs: PDFLineStyle, rhs: PDFLineStyle) -> Bool {
        guard lhs.type == rhs.type else { return false }
        guard lhs.color == rhs.color else { return false }
        guard lhs.width == rhs.width else { return false }
        return true
    }

    // MARK: - Hashable

    public func hash(into hasher: inout Hasher) {
        hasher.combine(type)
        hasher.combine(color)
        hasher.combine(width)
    }
}

// MARK: - Defaults

extension PDFLineStyle {

    /// Shorthand method for creating an invisible line
    public static var none: PDFLineStyle {
        PDFLineStyle(type: .none, width: 0)
    }
}
