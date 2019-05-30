//
//  PDFTable+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

/**
 TODO: Documentation
 */
extension PDFTable: Equatable {

    /**
     TODO: Documentation
     */
    public static func == (lhs: PDFTable, rhs: PDFTable) -> Bool {
        guard lhs.style == rhs.style else {
            return false
        }
        guard lhs.cells.count == rhs.cells.count else {
            return false
        }
        for i in 0..<lhs.cells.count where lhs.cells[i] != rhs.cells[i] {
            return false
        }
        guard lhs.widths == rhs.widths else {
            return false
        }
        guard lhs.padding == rhs.padding else {
            return false
        }
        guard lhs.margin == rhs.margin else {
            return false
        }
        guard lhs.showHeadersOnEveryPage == rhs.showHeadersOnEveryPage else {
            return false
        }
        return true
    }

}
