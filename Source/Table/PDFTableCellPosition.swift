//
//  PDFTableCellPosition.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//

/**
 TODO: Documentation
 */
public struct PDFTableCellPosition {

    /**
     TODO: Documentation
     */
    public var row: Int

    /**
     TODO: Documentation
     */
    public var column: Int

    /**
     TODO: Documentation
     */
    public init(row: Int, column: Int) {
        self.row = row
        self.column = column
    }
}

extension PDFTableCellPosition: PDFJSONSerializable {}
