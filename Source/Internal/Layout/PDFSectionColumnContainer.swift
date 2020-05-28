//
//  PDFSectionContainer.swift
//  TPPDF
//
//  Created by Marco Betschart on 05.05.18.
//

/**
 A section container defines the position of an element in a column of a given container.
 */
public enum PDFSectionColumnContainer {

    /**
     Element is in no container, only real use is as a default value
     */
    case none

    /**
     Container aligned to left
     */
    case left

    /**
     Container aligned to center
     */
    case center

    /**
     Container aligned to right
     */
    case right

    /**
     Array of all possible containers, expect `.none`.
     Useful for initalizing default values for each container
     */
    internal static var all: [PDFSectionColumnContainer] {
        [.left, .center, .right]
    }

    /**
     Returns the mapped `PDFContainer`
     */
    internal var contentContainer: PDFContainer {
        switch self {
        case .left: return PDFContainer.contentLeft
        case .center: return PDFContainer.contentCenter
        case .right: return PDFContainer.contentRight
        default: return PDFContainer.none
        }
    }
}
