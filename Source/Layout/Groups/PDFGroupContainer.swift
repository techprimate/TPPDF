//
//  PDFGroupContainer.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 31.05.19.
//

/**
 A section container defines the position of an element in a column of a given container.
 */
public enum PDFGroupContainer {

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


    internal init(from container: PDFContainer) {
        if container.isLeft {
            self = .left
        } else if container.isRight {
            self = .right
        } else {
            self = .center
        }
    }

    /**
     Array of all possible containers, expect `.none`.
     Useful for initalizing default values for each container
     */
    internal static var all: [PDFGroupContainer] {
        return [.left, .center, .right]
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

// MARK: - JSON Serialization

extension PDFGroupContainer: PDFJSONSerializable {

    /**
     Creates a representable object
     */
    public var JSONRepresentation: AnyObject {
        switch self {
        case .none:
            return 0 as AnyObject
        case .left:
            return 1 as AnyObject
        case .center:
            return 2 as AnyObject
        case .right:
            return 3 as AnyObject
        }
    }
}
