//
//  PDFTableCellBorders.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

/**
 TODO: Documentation
 */
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
     TODO: Documentation
     */
    public init(left: PDFLineStyle = .none,
                top: PDFLineStyle = .none,
                right: PDFLineStyle = .none,
                bottom: PDFLineStyle = .none) {
        self.left = left
        self.top = top
        self.right = right
        self.bottom = bottom
    }

    // MARK: - Equatable

    public static func == (lhs: PDFTableCellBorders, rhs: PDFTableCellBorders) -> Bool {
        guard lhs.left == rhs.left else { return false }
        guard lhs.top == rhs.top else { return false }
        guard lhs.right == rhs.right else { return false }
        guard lhs.bottom == rhs.bottom else { return false }
        return true
    }

    // MARK: - Hashable

    public func hash(into hasher: inout Hasher) {
        hasher.combine(left)
        hasher.combine(top)
        hasher.combine(right)
        hasher.combine(bottom)
    }
}

// MARK: - Defaults

extension PDFTableCellBorders {

    public static let none = PDFTableCellBorders(left: .none, top: .none, right: .none, bottom: .none)

}
