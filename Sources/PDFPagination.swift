//
//  PDFPagination.swift
//  Pods
//
//  Created by Philip Niedertscheider on 11/08/2017.
//
//

import Foundation

public struct PDFPagination {
    
    public var container: PDFContainer
    public var style: PDFPaginationStyle
    public var range: (start: Int, end: Int)
    public var hiddenPages: [Int]
    
    public init(container: PDFContainer = .none, style: PDFPaginationStyle = .Default, range: (start: Int, end: Int) = (0, Int.max), hiddenPages: [Int] = []) {
        self.container = container
        self.style = style
        self.range = range
        self.hiddenPages = hiddenPages
    }
}
