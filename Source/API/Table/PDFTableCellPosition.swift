//
//  PDFTableCellPosition.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//

/**
 A cell position represent the coordinate of a cell in a given table
 */
public struct PDFTableCellPosition {

    /**
     Vertical row index, starting at zero
     */
    public var row: Int

    /**
     Horizontal column index, starting at zero
     */
    public var column: Int

    /**
     Creates a new position with the given row and column
     */
    public init(row: Int, column: Int) {
        self.row = row
        self.column = column
    }
}
