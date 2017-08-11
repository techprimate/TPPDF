//
//  PDFTableValidator.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//
//

import Foundation

class PDFTableValidator {
    
    public static func validateCells(cells: [[PDFTableCell]], columnWidths: [CGFloat]) throws {
        // Throw error when empty. Signalizes developer he tries to render an empty table. Might cause format errors
        if cells.count == 0 {
            throw PDFError.tableIsEmpty
        }
        
        // Compare each data row
        for (rowIdx, row) in cells.enumerated() {
            
            // Throw error when columns row count does not equal relativeColumnWidth count
            if row.count != columnWidths.count {
                throw PDFError.tableStructureInvalid(message: "Data and alignment for row with index \(rowIdx) does not have the same amount!")
            }
        }
    }
    
    public static func validateTableData(data: [[Any?]], alignments: [[PDFTableCellAlignment]]? = nil, columnWidths: [CGFloat]? = nil) throws {
        // Throw error when empty. Signalizes developer he tries to render an empty table. Might cause format errors
        if data.count == 0 {
            throw PDFError.tableIsEmpty
        }
        
        if let alignments = alignments {
            // Throw error when data row count does not equal alignment row count
            if data.count != alignments.count {
                throw PDFError.tableStructureInvalid(message: "Data and alignment must be equal size!")
            }
        }
        
        // Compare each data row
        for (rowIdx, row) in data.enumerated() {
            if let alignments = alignments {
                // Throw error when columns count does not equal alignment columns count
                if row.count != alignments[rowIdx].count {
                    throw PDFError.tableStructureInvalid(message: "Data and alignment for row with index \(rowIdx) does not have the same amount!")
                }
            }
            
            if let columnWidths = columnWidths {
                // Throw error when columns row count does not equal relativeColumnWidth count
                if row.count != columnWidths.count {
                    throw PDFError.tableStructureInvalid(message: "Data and alignment for row with index \(rowIdx) does not have the same amount!")
                }
            }
        }
    }
    
}
