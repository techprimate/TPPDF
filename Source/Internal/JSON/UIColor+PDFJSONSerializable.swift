//
//  UIColor+PDFJSONSerializable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 30.05.19.
//

import Foundation

/**
 TODO: Documentation
 */
extension UIColor: PDFJSONSerializable {

    /**
     TODO: Documentation
     */
    public var JSONRepresentation: AnyObject {
        return self.hex as AnyObject
    }
}
