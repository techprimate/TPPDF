//
//  PDFTableCellStyle+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

/**
 TODO: Documentation
 */
extension PDFTableCellStyle: Equatable {

    /**
     TODO: Documentation
     */
    public static func == (lhs: PDFTableCellStyle, rhs: PDFTableCellStyle) -> Bool {
        guard lhs.colors == rhs.colors else {
            return false
        }
        guard lhs.borders == rhs.borders else {
            return false
        }
        guard lhs.font == rhs.font else {
            return false
        }
        return true
    }

}
