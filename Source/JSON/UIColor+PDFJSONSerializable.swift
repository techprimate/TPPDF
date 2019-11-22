//
//  UIColor+PDFJSONSerializable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 30.05.19.
//

import Foundation
import UIKit

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
