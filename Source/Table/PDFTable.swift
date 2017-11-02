//
//  PDFTable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//

public class PDFTable: TPJSONSerializable {
    
    public var style: PDFTableStyle = PDFTableStyleDefaults.simple
    public var cells: [[PDFTableCell]] = []
    public var widths: [CGFloat] = []
    
    public var padding: CGFloat = 0
    public var margin: CGFloat = 0
    
    public var showHeadersOnEveryPage: Bool = false
    
    public init() {}
    
    public func generateCells(data: [[Any?]], alignments: [[PDFTableCellAlignment]]) throws {
        try PDFTableValidator.validateTableData(data: data, alignments: alignments)
        
        self.cells = []
        
        for (rowIndex, row) in data.enumerated() {
            var contentRow = [PDFTableCell]()
            for (colIndex, col) in row.enumerated() {
                let content = try PDFTableContent(content: col)
                let alignment = alignments[rowIndex][colIndex]
                
                let cell = PDFTableCell(content: content, alignment: alignment)
                contentRow.append(cell)
            }
            self.cells.append(contentRow)
        }
    }
    
    public func setCellStyle(row rowIndex: Int, column columnIndex: Int, style cellStyle: PDFTableCellStyle?) throws {
        if rowIndex < 0 || rowIndex >= cells.count {
            throw PDFError.tableIndexOutOfBounds(index: rowIndex, length: cells.count)
        }
        if columnIndex < 0 || columnIndex >= cells[rowIndex].count {
            throw PDFError.tableIndexOutOfBounds(index: columnIndex, length: cells[rowIndex].count)
        }
        
        let cell = cells[rowIndex][columnIndex]
        cell.style = cellStyle
    }
}
