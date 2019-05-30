//
//  UIImage+PDFJSONSerializable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 30.05.19.
//

import Foundation
import UIKit

extension UIImage: PDFJSONSerializable {

    public var JSONRepresentation: AnyObject {
        return self.jpegData(compressionQuality: 1.0)?.JSONRepresentation ?? NSNull()
    }
}
