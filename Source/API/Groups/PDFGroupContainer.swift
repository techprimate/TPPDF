//
//  PDFGroupContainer.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 31.05.19.
//

/// A section container defines the position of an element in a column of a given container.
public enum PDFGroupContainer {
    /// Element is in no container, only real use is as a default value
    case none

    /// Container aligned to left
    case left

    /// Container aligned to center
    case center

    /// Container aligned to right
    case right

    /**
     * Convenience initializer to convert a ``PDFContainer`` into a ``PDFGroupContainer``
     *
     * - Parameter container: Container to convert
     */
    init(from container: PDFContainer) {
        if container.isLeft {
            self = .left
        } else if container.isRight {
            self = .right
        } else {
            self = .center
        }
    }

    /**
     * Array of all possible containers, expect `.none`.
     *
     * Useful for initializing default values for each container
     */
    static var all: [PDFGroupContainer] {
        [.left, .center, .right]
    }

    /// Returns the mapped `PDFContainer`
    var contentContainer: PDFContainer {
        switch self {
        case .left:
            return PDFContainer.contentLeft
        case .center:
            return PDFContainer.contentCenter
        case .right:
            return PDFContainer.contentRight
        default:
            return PDFContainer.none
        }
    }
}
