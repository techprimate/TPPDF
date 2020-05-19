//
//  PDFCopy.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 06.04.18.
//

/**
 A protocol that objects adopt to provide functional copies of themselves.
 */
public protocol PDFCopy {

    /**
     Type of intance, used to add generic to protocol
     */
    associatedtype Element

    /**
     Returns a new instance that’s a copy of the receiver.
     */
    var copy: Element { get }

}
