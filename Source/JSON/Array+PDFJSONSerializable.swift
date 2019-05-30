//
//  Array+PDFJSONSerializable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 30.05.19.
//

extension Array: PDFJSONSerializable {

    public var JSONRepresentation: AnyObject {
        var representation: [Any] = []

        for (value) in self {
            representation.append(convertValue(value))
        }

        return representation as NSArray
    }

}
