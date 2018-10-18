//
//  PDFLineType.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 02/11/2017.
//

/**
 These types of lines are available for rendering

 - full: Line without any breaks
 - dashed: Line consists out of short dashes
 - dotted: Lines consists out of dots
 */
public enum PDFLineType {

    /**
     No visible line
     */
    case none

    /**
     Full line
     */
    case full

    /**
     Line is dashed, dash length and spacing is three times the line width
     */
    case dashed

    /**
     Line is dotted. Dot spacing is twice the line width
     */
    case dotted

}

// MARK: - JSON Serialization

extension PDFLineType: PDFJSONSerializable {

    /**
     Creates a serializable object
     */
    public var JSONRepresentation: AnyObject {
        switch self {
        case .none:
            return 0 as AnyObject
        case .full:
            return 1 as AnyObject
        case .dashed:
            return 2 as AnyObject
        case .dotted:
            return 3 as AnyObject
        }
    }
}
