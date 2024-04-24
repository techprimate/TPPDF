//
//  PDFImageOptions.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12.07.18.
//

/**
 * Options used to configure the behaviour of ``PDFImage``
 *
 * Multiple options can be combined by using the ``OptionSet`` operators, i.e. using the array syntax.
 *
 * **Example:**
 *
 * ```swift
 * let image = PDFImage(
 *     options: [.resize, .compress]
 * )
 * ```
 */
public struct PDFImageOptions: OptionSet, Hashable {
    /// nodoc
    public let rawValue: Int

    /// nodoc
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    /// Image will be resized to the calculated frame
    public static let resize = PDFImageOptions(rawValue: 1 << 0)

    /// Image will be compressed using the value set in the property `quality`
    public static let compress = PDFImageOptions(rawValue: 1 << 1)

    /// Top-left corner of image will be rounded
    public static let roundedTopLeft = PDFImageOptions(rawValue: 1 << 2)

    /// Top-right corner of image will be rounded
    public static let roundedTopRight = PDFImageOptions(rawValue: 1 << 3)

    /// Bottom-right corner of image will be rounded
    public static let roundedBottomRight = PDFImageOptions(rawValue: 1 << 4)

    /// Bottom-left corner of image will be rounded
    public static let roundedBottomLeft = PDFImageOptions(rawValue: 1 << 5)

    /// Short-hand option to round all corners
    public static let rounded = PDFImageOptions(rawValue: 1 << 6)

    /// Disables all options
    public static let none = PDFImageOptions(rawValue: 1 << 7)
}
