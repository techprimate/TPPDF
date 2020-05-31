//
//  PDFContainer.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/16.
//

/**
 A container defines the position of an element in the page.

 Generally a document is vertically split up into a header, a content and a footer area.
 Also each part is horizontally split up into a left, a center and a right area.
 */
public enum PDFContainer: CaseIterable {

    /**
     Element is in no container, only real use is as a default value
     */
    case none

    /**
     Container at the top left
     */
    case headerLeft

    /**
     Container at the top center
     */
    case headerCenter

    /**
     Container at the top right
     */
    case headerRight

    /**
     Container in the center, aligned to left
     */
    case contentLeft

    /**
     Container in the center, aligned to center
     */
    case contentCenter

    /**
     Container in the center, aligned to right
     */
    case contentRight

    /**
     Container at the bottom left
     */
    case footerLeft

    /**
     Container at the bottom center
     */
    case footerCenter

    /**
     Container at the bottom right
     */
    case footerRight

    /**
     Checks if this container is in the header area
     */
    internal var isHeader: Bool {
        switch self {
        case .headerLeft, .headerCenter, .headerRight:
            return true
        default:
            return false
        }
    }

    /**
     Checks if this container is in the footer area
     */
    internal var isFooter: Bool {
        switch self {
        case .footerLeft, .footerCenter, .footerRight:
            return true
        default:
            return false
        }
    }

    /**
     Checks if this container is neither in header nor in footer, therefore in the center area
     */
    internal var isCenter: Bool {
        !isHeader && !isFooter
    }

    /**
     Checks if this container is on the left side
     */
    internal var isLeft: Bool {
        switch self {
        case .headerLeft, .contentLeft, .footerLeft:
            return true
        default:
            return false
        }
    }

    /**
     Checks if this container is on the right side
     */
    internal var isRight: Bool {
        switch self {
        case .headerRight, .contentRight, .footerRight:
            return true
        default:
            return false
        }
    }

    /**
     Array of all possible containers, expect `.none`.
     Useful for initalizing default values for each container
     */
    internal static var all: [PDFContainer] {
        [
            .headerLeft, .headerCenter, .headerRight,
            .contentLeft, .contentCenter, .contentRight,
            .footerLeft, .footerCenter, .footerRight
        ]
    }
}
