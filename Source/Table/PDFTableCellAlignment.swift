//
//  PDFTableCellAlignment.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//
//

public enum PDFTableCellAlignment: TPJSONSerializable {
    case topLeft, top, topRight
    case left, center, right
    case bottomLeft, bottom, bottomRight
    
    var normalizeVertical: PDFTableCellAlignment {
        switch self {
        case .topLeft, .top, .topRight:
            return .top
        case .left, .center, .right:
            return .center
        case .bottomLeft, .bottom, .bottomRight:
            return .bottom
        }
    }
    
    var normalizeHorizontal: PDFTableCellAlignment {
        switch self {
        case .topLeft, .left, .bottomLeft:
            return .left
        case .top, .center, .bottom:
            return .center
        case .topRight, .right, .bottomRight:
            return .right
        }
    }
    
    // MARK: - JSON Serialization
    
    public var JSONRepresentation: AnyObject {
        return self.hashValue as AnyObject
    }
}
