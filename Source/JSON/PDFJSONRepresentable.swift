//
//  JSONRepresentable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

/**
 A object must implement this protocol to be serialized into a JSON
 */
public protocol PDFJSONRepresentable {

    /**
     Creates a representable object
     */
    var JSONRepresentation: AnyObject { get }

}
