//
//  PDFError.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//

public enum PDFError: Error {

    case tableContentInvalid(value: Any?)
    case tableIsEmpty
    case tableStructureInvalid(message: String)
    case tableIndexOutOfBounds(index: Int, length: Int)
    case tableCellWeakReferenceBroken

    case textObjectIsNil
    case textObjectNotCalculated

    case invalidHexLength(length: Int)
    case invalidHex(hex: String)

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
        }
    }
}
