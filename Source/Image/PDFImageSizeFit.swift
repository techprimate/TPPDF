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

    case width
    case height
    case widthHeight

}

// MARK: - JSON Serialization

extension PDFImageSizeFit: PDFJSONSerializable {

    /**
     Creates representable object
     */
    public var JSONRepresentation: AnyObject {
        return self.hashValue as AnyObject
    }
}
