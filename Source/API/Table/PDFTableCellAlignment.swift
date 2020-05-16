//
//  PDFTableCellAlignment.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//

/**
 Options for aligning content inside a table cell
 */
public enum PDFTableCellAlignment {

    /**
     Content will be aligned in the top left corner
     */
    case topLeft

    /**
     Content will be aligned with the top edge, centered horizontally
     */
    case top

    /**
     Content will be aligned in the top right corner
     */
    case topRight

    /**
     Content will be aligned with the left edge, centered vertically
     */
    case left

    /**
     Content will be centered horizontally & vertically
     */
    case center

    /**
     Content will be aligned with the right edge, centered horizontally
     */
    case right

    /**
     Content will be aligned in the bottom left corner
     */
    case bottomLeft

    /**
     Content will be aligned with the bottom edge, centered horizontally
     */
    case bottom

    /**
     Content will be aligned in the top right corner
     */
    case bottomRight

    /**
     Alignment is at the top edge
     */
    internal var isTop: Bool {
        switch self {
        case .topLeft, .top, .topRight:
            return true
        default:
            return false
        }
    }

    /**
     Alignment is at the bottom side
     */
    internal var isBottom: Bool {
        switch self {
        case .bottomLeft, .bottom, .bottomRight:
            return true
        default:
            return false
        }
    }

    /**
     Alignment is on the left side
     */
    internal var isLeft: Bool {
        switch self {
        case .topLeft, .left, .bottomLeft:
            return true
        default:
            return false
        }
    }

    /**
     Alignment is on the right side
     */
    internal var isRight: Bool {
        switch self {
        case .topRight, .right, .bottomRight:
            return true
        default:
            return false
        }
    }
}
