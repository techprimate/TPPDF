//
//  PDFError.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//

import Foundation

/// List of errors which can be thrown during configuration, calculations or rendering
public enum PDFError: LocalizedError {
    /// The associated `value` is an instance of an unsupported type.
    case tableContentInvalid(value: Any?)

    /// Indicates that a table without any data was added to the document, which is unsupported
    case tableIsEmpty

    /// The given table structure does not match, i.e. the data matrix size does not match the cell alignment configuration
    case tableStructureInvalid(message: String)

    /// Thrown when accessing a cell outside of the table bounds
    case tableIndexOutOfBounds(index: Int, length: Int)

    /// Indicates that the cell is too big to be rendered onto a single page
    case tableCellTooBig(cell: PDFTableCell)

    /// Thrown when neither a ``PDFSimpleText`` nor a ``UIKit/NSAttributedString`` is set in an ``PDFAttributedText``
    case textObjectIsNil

    /// Thrown when a ``PDFAttributedText`` should be rendered without being calculated first
    case textObjectNotCalculated

    /// Thrown when copying of a PDF object fails
    case copyingFailed

    /// Thrown when an external PDF document could not be loaded from the given `url`
    case externalDocumentURLInvalid(url: URL)

    /// Index of page in external document is out of bounds
    case pageOutOfBounds(index: Int)

    /// nodoc
    public var errorDescription: String? {
        switch self {
        case let .tableContentInvalid(value):
            return "Table content is invalid: " + value.debugDescription
        case .tableIsEmpty:
            return "Table is empty"
        case let .tableStructureInvalid(message):
            return "Table structure invalid: " + message
        case let .tableIndexOutOfBounds(index, length):
            return "Table index out of bounds: <index: \(index), length: \(length)>"
        case let .tableCellTooBig(cell):
            return "Table cell is too big to be rendered: \(cell)"
        case .textObjectIsNil:
            return "No text object has been set"
        case .textObjectNotCalculated:
            return "Text object is missing string, maybe not calculated?"
        case .copyingFailed:
            return "Failed to create a copy of an object"
        case let .externalDocumentURLInvalid(url):
            return "Could not open PDF document at url: " + url.absoluteString
        case let .pageOutOfBounds(index):
            return "Page \(index) in external document is out of bounds"
        }
    }
}
