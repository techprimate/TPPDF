//
//  PDFLocatedRenderObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 22.12.19.
//

/// Structure to extend ``PDFRenderObject`` with the ``PDFContainer`` it is located in
public typealias PDFLocatedRenderObject = (PDFContainer, PDFRenderObject)
