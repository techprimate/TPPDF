//
//  Table.swift
//  Pods
//
//  Created by Philip Niedertscheider on 13/06/2017.
//
//

import Foundation

open class Table {
    
    open var style: TableStyle = TableStyleDefaults.simple
    open var data: [[TableContent?]] = []
    open var alignments: [[TableCellAlignment]] = []
    open var widths: [CGFloat] = []
    open var padding: Int = 0
    open var margin: Int = 0
    open var showHeadersOnEveryPage: Bool = false
    
    public init() { }
    
    public func setCellStyle(row: Int, column: Int, style cellStyle: TableCellStyle) {
        style.setCellStyle(row: row, column: column, style: cellStyle)
    }
}
