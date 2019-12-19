//
//  PDFTableCellAlignment.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//

/**
 TODO: Documentation
 */
public enum PDFTableCellAlignment {

    /**
     TODO: Documentation
     */
    case topLeft

    /**
     TODO: Documentation
     */
    case top

    /**
     TODO: Documentation
     */
    case topRight

    /**
     TODO: Documentation
     */
    case left

    /**
     TODO: Documentation
     */
    case center

    /**
     TODO: Documentation
     */
    case right

    /**
     TODO: Documentation
     */
    case bottomLeft

    /**
     TODO: Documentation
     */
    case bottom

    /**
     TODO: Documentation
     */
    case bottomRight

    /**
     Alignment is at the top side
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
