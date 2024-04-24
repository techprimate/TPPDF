//
//  PDFExternalDocument.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12.08.19.
//

import Foundation

/// Document object used for including an external PDF document
public class PDFExternalDocument {
    /// File URL to an external document
    public private(set) var url: URL

    /**
     * Array of page indicies which should be included from external documents
     *
     * - Note: An empty array will be result in all pages to be included.
     */
    public var pages: [Int] = []

    /**
     * Creates a new instance using the given `url` to locate and the `pages` parameter to select the pages.
     *
     * - Parameter url: Location of file
     * - Parameter pages: Variadic argument of page indicies
     */
    public convenience init(url: URL, pages: Int...) {
        self.init(url: url, pages: pages)
    }

    /**
     * Creates a new instance using the given `url` to locate and the `pages` parameter to select the pages.
     *
     * - Parameter url: Location of file
     * - Parameter pages: Array of page indicies
     */
    public init(url: URL, pages: [Int]) {
        self.url = url
        self.pages = pages
    }
}
