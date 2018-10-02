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
	static var all: [PDFSectionColumnContainer] {
		return [.left, .center, .right]
	}

	/**
	Returns the mapped `PDFContainer`
	*/
	var contentContainer: PDFContainer {
		switch self {
		case .left: return PDFContainer.contentLeft
		case .center: return PDFContainer.contentCenter
		case .right: return PDFContainer.contentRight
		default: return PDFContainer.none
		}
	}
}

// MARK: - JSON Serialization

extension PDFSectionColumnContainer: PDFJSONSerializable {

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
