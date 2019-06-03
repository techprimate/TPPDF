//
//  PDFError.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//

/**
 TODO: Documentation
 */
public enum PDFError: Error {

    /**
     TODO: Documentation
     */
    case tableContentInvalid(value: Any?)

    /**
     TODO: Documentation
     */
    case tableIsEmpty

    /**
     TODO: Documentation
     */
    case tableStructureInvalid(message: String)

    /**
     TODO: Documentation
     */
    case tableIndexOutOfBounds(index: Int, length: Int)

    /**
     TODO: Documentation
     */
    case tableCellWeakReferenceBroken

    /**
     TODO: Documentation
     */
    case textObjectIsNil

    /**
     TODO: Documentation
     */
    case textObjectNotCalculated

    /**
     TODO: Documentation
     */
    case invalidHexLength(length: Int)

    /**
     TODO: Documentation
     */
    case invalidHex(hex: String)

    /**
     TODO: Documentation
     */
    case copyingFailed

    /**
     TODO: Documentation
     */
    public var localizedDescription: String {
        switch self {
        case .tableContentInvalid(let value):
            return "Table content is invalid: " + value.debugDescription
        case .tableIsEmpty:
            return "Table is empty"
        case .tableStructureInvalid(let message):
            return "Table structure invalid: " + message
        case .tableIndexOutOfBounds(let index, let length):
            return "Table index out of bounds: <index: \(index), length: \(length)>"
        case .tableCellWeakReferenceBroken:
            return "Weak reference in table cell is broken"
        case .textObjectIsNil:
            return "No text object has been set"
        case .textObjectNotCalculated:
            return "Text object is missing string, maybe not calculated?"
        case .invalidHexLength(let length):
            return "Hex color string has invalid length: \(length)"
        case .invalidHex(let hex):
            return "Invalid hexdecimal string: " + hex
        case .copyingFailed:
            return "Failed to create a copy of an object"
        }
    }
}
