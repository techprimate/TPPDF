//
//  PDFAttributableObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 19.12.19.
//

public protocol PDFAttributableObject {

    var attributes: [PDFObjectAttribute] { get }

    func add(attribute: PDFObjectAttribute)

}
