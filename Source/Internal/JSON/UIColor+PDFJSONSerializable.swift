//
//  UIColor+PDFJSONSerializable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 30.05.19.
//

import UIKit

/**
 TODO: Documentation
 */
extension UIColor: PDFJSONSerializable {

    /**
     TODO: Documentation
     */
    public var JSONRepresentation: AnyObject {
        self.hex as AnyObject
    }
}
