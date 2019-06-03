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
    case topLeft, top, topRight
    case left, center, right
    case bottomLeft, bottom, bottomRight

    /**
     Alignment is at the top side
     */
    var isTop: Bool {
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
    var isBottom: Bool {
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
    var isLeft: Bool {
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
    var isRight: Bool {
        switch self {
        case .topRight, .right, .bottomRight:
            return true
        default:
            return false
        }
    }
}
