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

}
