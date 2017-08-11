//
//  Table.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//
//

import Foundation

open class PDFTable {
    
    open var style: TableStyle = TableStyleDefaults.simple
    open var data: [[PDFTableContent?]] = []
    open var alignments: [[TableCellAlignment]] = []
    open var widths: [CGFloat] = []
    open var padding: Int = 0
    open var margin: Int = 0
    open var showHeadersOnEveryPage: Bool = false
    
    public init() { }
    
    public func setData(data: [[Any?]]) throws {
        self.data = []
        
        for row in data {
            var contentRow = [PDFTableContent]()
            for col in row {
                let content = try PDFTableContent(content: col)
                contentRow.append(content)
            }
            self.data.append(contentRow)
        }
    }
    
    public func setCellStyle(row: Int, column: Int, style cellStyle: TableCellStyle) {
        style.setCellStyle(row: row, column: column, style: cellStyle)
    }
}
