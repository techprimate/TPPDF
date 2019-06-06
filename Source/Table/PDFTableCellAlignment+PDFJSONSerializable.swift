//
//  PDFTableCellAlignment+PDFJSONSerializable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 30.05.19.
//

import Foundation

/**
 Extends the table cell alignment to be serializable into a JSON
 */
extension PDFTableCellAlignment: PDFJSONSerializable {

    /**
     Creates a representable object
     */
    public var JSONRepresentation: AnyObject {
        switch self {
        case .topLeft:
            return 0 as AnyObject
        case .top:
            return 1 as AnyObject
        case .topRight:
            return 2 as AnyObject
        case .left:
            return 3 as AnyObject
        case .center:
            return 4 as AnyObject
        case .right:
            return 5 as AnyObject
        case .bottomLeft:
            return 6 as AnyObject
        case .bottom:
            return 7 as AnyObject
        case .bottomRight:
            return 8 as AnyObject
        }
    }
}
