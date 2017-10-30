//
//  PDFTableValidator.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//
//

class PDFTableValidator {
    
    public static func validateTable(table: PDFTable) throws {
        // Throw error when empty. Signalizes developer he tries to render an empty table. Might cause format errors
        if table.cells.count == 0 {
            throw PDFError.tableIsEmpty
        }
        
        // Compare each data row
        for (rowIdx, row) in table.cells.enumerated() {
            
            // Throw error when columns row count does not equal relativeColumnWidth count
            if row.count != table.widths.count {
                throw PDFError.tableStructureInvalid(message: "Data and alignment for row with index \(rowIdx) does not have the same amount!")
            }
        }
    }
    
    public static func validateTableData(data: [[Any?]], alignments: [[PDFTableCellAlignment]]? = nil, columnWidths: [CGFloat]? = nil) throws {
        // Throw error when empty. Signalizes developer he tries to render an empty table. Might cause format errors
        if data.count == 0 {
            throw PDFError.tableIsEmpty
        }
        
        // Throw error when data row count does not equal alignment row count
        if alignments != nil && data.count != alignments!.count {
            throw PDFError.tableStructureInvalid(message: "Data and alignment must be equal size!")
        }
        
        // Compare each data row
        for (rowIdx, row) in data.enumerated() {
            // Throw error when columns count does not equal alignment columns count
            if alignments != nil && row.count != alignments![rowIdx].count {
                throw PDFError.tableStructureInvalid(message: "Data and alignment for row with index \(rowIdx) does not have the same amount!")
            }
            
            // Throw error when columns row count does not equal relativeColumnWidth count
            if columnWidths != nil && row.count != columnWidths!.count {
                throw PDFError.tableStructureInvalid(message: "Data and alignment for row with index \(rowIdx) does not have the same amount!")
            }
        }
    }
    
}
