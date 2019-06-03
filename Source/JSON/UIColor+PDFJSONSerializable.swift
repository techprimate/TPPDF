//
//  UIColor+PDFJSONSerializable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 30.05.19.
//

import Foundation

extension UIColor: PDFJSONSerializable {

    public var JSONRepresentation: AnyObject {
        return self.hex as AnyObject
    }
}
