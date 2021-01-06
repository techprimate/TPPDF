//
//  PDFError.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//

import Foundation

/**
 List of errors which can occur during using this framework
 */
public enum PDFError: LocalizedError {

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

    /// Indicates that the cell is too big to be rendered onto a single page
    case tableCellTooBig(cell: PDFTableCell)

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
    case externalDocumentURLInvalid(url: URL)

    /// Index of page in external document is out of bounds
    case pageOutOfBounds(index: Int)

    /**
     TODO: Documentation
     */
    public var errorDescription: String? {
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
        case .tableCellTooBig(let cell):
            return "Table cell is too big to be rendered: \(cell)"
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
        case .externalDocumentURLInvalid(let url):
            return "Could not open PDF document at url: " + url.absoluteString
        case .pageOutOfBounds(let index):
            return "Page \(index) in external document is out of bounds"
        }
    }
}
