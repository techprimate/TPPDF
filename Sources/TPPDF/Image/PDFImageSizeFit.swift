//
//  PDFImageSizeFit.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 02/11/2017.
//

/**
 Constants defining scaling behaviour of an image, if not enough space to render full size is given.
 */
public enum PDFImageSizeFit {

    /**
     TODO: documentation
     */
    case width

    /**
     TODO: documentation
     */
    case height

    /**
     TODO: documentation
     */
    case widthHeight

}

// MARK: - JSON Serialization

extension PDFImageSizeFit: PDFJSONSerializable {

    /**
     Creates representable object
     */
    public var JSONRepresentation: AnyObject {
        switch self {
        case .width:
            return 0 as AnyObject
        case .height:
            return 1 as AnyObject
        case .widthHeight:
            return 2 as AnyObject
        }
    }
}
