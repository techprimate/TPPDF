//
//  PDFImageSizeFit.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 02/11/2017.
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
