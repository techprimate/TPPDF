//
//  PDFDocumentObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 19.12.19.
//

import Foundation

public class PDFDocumentObject: PDFAttributableObject, PDFTaggableObject {

    public var attributes: [PDFObjectAttribute] = []
    public var tag: Int = 0

    public init() {}

    public func add(attribute: PDFObjectAttribute) {
        attributes.append(attribute)
    }
}
