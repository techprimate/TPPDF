//
//  PDFCopy.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 06.04.18.
//

public protocol PDFCopy {
    associatedtype Element

    var copy: Element { get }

}
