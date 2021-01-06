//
//  PDFImageOptions.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12.07.18.
//

/**
 TODO: documentation
 */
public struct PDFImageOptions: OptionSet, Hashable {

    /**
     TODO: documentation
     */
    public let rawValue: Int

    /**
     TODO: documentation
     */
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    /**
     TODO: documentation
     */
    public static let resize = PDFImageOptions(rawValue: 1 << 0)

    /**
     TODO: documentation
     */
    public static let compress = PDFImageOptions(rawValue: 1 << 1)

    /**
     TODO: documentation
     */
    public static let roundedTopLeft = PDFImageOptions(rawValue: 1 << 2)

    /**
     TODO: documentation
     */
    public static let roundedTopRight = PDFImageOptions(rawValue: 1 << 3)

    /**
     TODO: documentation
     */
    public static let roundedBottomRight = PDFImageOptions(rawValue: 1 << 4)

    /**
     TODO: documentation
     */
    public static let roundedBottomLeft = PDFImageOptions(rawValue: 1 << 5)

    /**
     TODO: documentation
     */
    public static let rounded = PDFImageOptions(rawValue: 1 << 6)

    /**
     TODO: documentation
     */
    public static let none = PDFImageOptions(rawValue: 1 << 7)

}
