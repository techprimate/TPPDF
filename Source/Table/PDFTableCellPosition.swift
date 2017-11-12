//
//  PDFTableCellPosition.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//

public struct PDFTableCellPosition: PDFJSONSerializable {
    
    public var row = -1
    public var column = -1
    
    public init(row: Int, column: Int) {
        self.row = row
        self.column = column
    }
}
