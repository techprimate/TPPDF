//
//  PDFTableCellPosition.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//

public struct PDFTableCellPosition {

    public var row: Int
    public var column: Int

    public init(row: Int, column: Int) {
        self.row = row
        self.column = column
    }

}

extension PDFTableCellPosition: PDFJSONSerializable {}
