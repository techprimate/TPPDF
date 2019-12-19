//
//  Array+PDFJSONSerializable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 30.05.19.
//

/**
 TODO: Documentation
 */
extension Array: PDFJSONSerializable {

    /**
     TODO: Documentation
     */
    public var JSONRepresentation: AnyObject {
        var representation: [Any] = []

        for (value) in self {
            representation.append(convertValue(value))
        }

        return representation as NSArray
    }

}
