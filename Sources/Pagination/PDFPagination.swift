//
//  PDFPagination.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//
//

public struct PDFPagination : TPJSONSerializable {
    
    public var container: PDFContainer
    public var style: PDFPaginationStyle
    public var range: (start: Int, end: Int)
    public var hiddenPages: [Int]
    
    public init(container: PDFContainer = .none, style: PDFPaginationStyle = .default, range: (start: Int, end: Int) = (0, Int.max), hiddenPages: [Int] = []) {
        self.container = container
        self.style = style
        self.range = range
        self.hiddenPages = hiddenPages
    }
}
