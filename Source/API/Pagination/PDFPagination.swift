//
//  PDFPagination.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//

#if os(iOS) || os(visionOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

/**
 * Structure used to configure the pagination
 */
public struct PDFPagination {
    /// Container where the pagination will be placed
    public var container: PDFContainer

    /// Style of the pagination
    public var style: PDFPaginationStyle

    /**
     * Range of pages which will be paginated
     *
     * This range starts at zero
     */
    public var range: (start: Int, end: Int)

    /**
     * Add a page number to this list to exclude it from the pagination
     *
     * This will not skip the page but instead not render the pagination object
     */
    public var hiddenPages: [Int]

    /**
     * Text attribtues are used to create the attributed pagination string
     *
     * See ``NSAttributedString`` for reference
     */
    public var textAttributes: [NSAttributedString.Key: Any]

    /**
     * Creates a new pagination configuration
     *
     * - Parameters;
     *     - container: Container where pagination is placed, defaults to `PDFContainer.none`, meaning it won't be rendered
     *     - style: Style of pagination
     *     - range: Start and end of pages which will be included
     *     - hiddenPages: List of numbers which are excluded from rendering
     */
    public init(
        container: PDFContainer = .none,
        style: PDFPaginationStyle = .default,
        range: (start: Int, end: Int) = (0, Int.max),
        hiddenPages: [Int] = [],
        textAttributes: [NSAttributedString.Key: Any] = [:]
    ) {
        self.container = container
        self.style = style
        self.range = range
        self.hiddenPages = hiddenPages
        self.textAttributes = textAttributes
    }
}
