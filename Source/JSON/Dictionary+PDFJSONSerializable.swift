//
//  Dictionary+PDFJSONSerializable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 30.05.19.
//

import Foundation

/**
 TODO: Documentation
 */
extension Dictionary: PDFJSONSerializable {

    /**
     TODO: Documentation
     */
    public var JSONRepresentation: AnyObject {
        let representation: NSMutableDictionary = [:]

        for (key, value) in self {
            representation[key] = convertValue(value)
        }

        return representation as NSDictionary
    }
}
