//
//  PDFImageSizeFit.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.02.2017.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

/// Constants defining scaling behaviour of an image, if not enough space to render full size is given.
public enum PDFImageSizeFit {
    /// Scale the image to fit the available width, while keeping the aspect ratio
    case width

    /// Scale the image to fit the available height, while keeping the aspect ratio
    case height

    /// Scale the image to fit the available width or height, while keeping the aspect ratio
    case widthHeight
}
