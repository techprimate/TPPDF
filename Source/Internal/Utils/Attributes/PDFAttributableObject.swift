//
//  PDFAttributableObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 19.12.19.
//

/**
 Protocol for adding attributes to an object
 */
public protocol PDFAttributableObject {

    /**
     - returns: List off attributes of this object
     */
    var attributes: [PDFObjectAttribute] { get }

    /**
     Adds an attribute to the list of this object

     - parameter attribute: Attribute used for further calculations
     */
    func add(attribute: PDFObjectAttribute)

}
