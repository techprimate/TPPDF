//
//  PDFTable+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

extension PDFTable: Equatable {

    public static func == (lhs: PDFTable, rhs: PDFTable) -> Bool {
        if lhs.style != rhs.style {
            return false
        }

        if lhs.cells.count != rhs.cells.count {
            return false
        }

        for i in 0..<lhs.cells.count where lhs.cells[i] != rhs.cells[i] {
            return false
        }

        if lhs.widths != rhs.widths {
            return false
        }

        if lhs.padding != rhs.padding {
            return false
        }

        if lhs.margin != rhs.margin {
            return false
        }

        if lhs.showHeadersOnEveryPage != rhs.showHeadersOnEveryPage {
            return false
        }

        return true
    }

}
