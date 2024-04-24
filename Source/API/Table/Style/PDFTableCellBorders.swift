//
//  PDFTableCellBorders.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

/// Structure used to style the border lines of a ``PDFTableCell``
public struct PDFTableCellBorders: Hashable {
    /// Style of left edge line
    public var left: PDFLineStyle

    /// Style of top edge line
    public var top: PDFLineStyle

    /// Style of right edge line
    public var right: PDFLineStyle

    /// Style of bottom edge line
    public var bottom: PDFLineStyle

    /**
     * Creates a new instance with the given line styles
     *
     * - Parameters:
     *     - left: See ``PDFTableCellBorders/left``
     *     - top: See ``PDFTableCellBorders/top``
     *     - right: See ``PDFTableCellBorders/right``
     *     - bottom: See ``PDFTableCellBorders/bottom``
     */
    public init(
        left: PDFLineStyle = .none,
        top: PDFLineStyle = .none,
        right: PDFLineStyle = .none,
        bottom: PDFLineStyle = .none
    ) {
        self.left = left
        self.top = top
        self.right = right
        self.bottom = bottom
    }

    // MARK: - Equatable

    /// nodoc
    public static func == (lhs: PDFTableCellBorders, rhs: PDFTableCellBorders) -> Bool {
        guard lhs.left == rhs.left else { return false }
        guard lhs.top == rhs.top else { return false }
        guard lhs.right == rhs.right else { return false }
        guard lhs.bottom == rhs.bottom else { return false }
        return true
    }

    // MARK: - Hashable

    /// nodoc
    public func hash(into hasher: inout Hasher) {
        hasher.combine(left)
        hasher.combine(top)
        hasher.combine(right)
        hasher.combine(bottom)
    }
}

// MARK: - Defaults

public extension PDFTableCellBorders {
    /// Convenience configuration for not displaying any cell border
    static let none = PDFTableCellBorders(left: .none, top: .none, right: .none, bottom: .none)
}
