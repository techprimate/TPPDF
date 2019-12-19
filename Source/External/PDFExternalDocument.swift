//
//  PDFExternalDocument.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12.08.19.
//

import Foundation

public class PDFExternalDocument {

    public private(set) var url: URL

    public var pages: [Int] = []

    public convenience init(url: URL, pages: Int...) {
        self.init(url: url, pages: pages)
    }

    public init(url: URL, pages: [Int]) {
        self.url = url
        self.pages = pages
    }
}
