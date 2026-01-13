//
//  PDFLocatedRenderObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 22.12.2019.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

/// Structure to extend ``PDFRenderObject`` with the ``PDFContainer`` it is located in
public typealias PDFLocatedRenderObject = (PDFContainer, PDFRenderObject)
