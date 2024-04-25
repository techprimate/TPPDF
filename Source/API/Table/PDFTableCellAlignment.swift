//
//  PDFTableCellAlignment.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//

/// Options for aligning content inside a table cell
public enum PDFTableCellAlignment: String {
    /// Content will be aligned in the top left corner
    case topLeft = "top-left"

    /// Content will be aligned with the top edge, centered horizontally
    case top

    /// Content will be aligned in the top right corner
    case topRight = "top-right"

    /// Content will be aligned with the left edge, centered vertically
    case left

    /// Content will be centered horizontally & vertically
    case center

    /// Content will be aligned with the right edge, centered horizontally
    case right

    /// Content will be aligned in the bottom left corner
    case bottomLeft = "bottom-left"

    /// Content will be aligned with the bottom edge, centered horizontally
    case bottom

    /// Content will be aligned in the top right corner
    case bottomRight = "bottom-right"

    /// Alignment is at the top edge
    var isTop: Bool {
        switch self {
        case .topLeft, .top, .topRight:
            return true
        default:
            return false
        }
    }

    /// Alignment is at the bottom side
    var isBottom: Bool {
        switch self {
        case .bottomLeft, .bottom, .bottomRight:
            return true
        default:
            return false
        }
    }

    /// Alignment is on the left side
    var isLeft: Bool {
        switch self {
        case .topLeft, .left, .bottomLeft:
            return true
        default:
            return false
        }
    }

    /// Alignment is on the right side
    var isRight: Bool {
        switch self {
        case .topRight, .right, .bottomRight:
            return true
        default:
            return false
        }
    }
}
