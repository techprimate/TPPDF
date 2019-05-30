//
//  Data+PDFJSONSerializable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 30.05.19.
//

import Foundation

extension Data: PDFJSONSerializable {

    public var JSONRepresentation: AnyObject {
        return self.base64EncodedString() as AnyObject
    }

}
