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
    public var start: Int
    public var end: Int
    public var hiddenPages: [Int]
    
    public init(container: PDFContainer = .none, style: PDFPaginationStyle = .Default, from start: Int = 0, to end: Int = Int.max, hiddenPages: [Int] = []) {
        self.container = container
        self.style = style
        self.start = start
        self.end = end
        self.hiddenPages = hiddenPages
    }
}
