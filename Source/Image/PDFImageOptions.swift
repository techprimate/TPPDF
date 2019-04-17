//
//  PDFImageOptions.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12.07.18.
//

public struct PDFImageOptions: OptionSet {

    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public static let resize = PDFImageOptions(rawValue: 1 << 0)
    public static let compress = PDFImageOptions(rawValue: 1 << 1)

    public static let roundedTopLeft = PDFImageOptions(rawValue: 1 << 2)
    public static let roundedTopRight = PDFImageOptions(rawValue: 1 << 3)
    public static let roundedBottomRight = PDFImageOptions(rawValue: 1 << 4)
    public static let roundedBottomLeft = PDFImageOptions(rawValue: 1 << 5)
    public static let rounded = PDFImageOptions(rawValue: 1 << 6)

    public static let none = PDFImageOptions(rawValue: 1 << 7)

}
