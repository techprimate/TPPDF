//
//  PDFLineStyle+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

extension PDFLineStyle: Equatable {

    /**
     TODO: Documentation
     */
    public static func == (lhs: PDFLineStyle, rhs: PDFLineStyle) -> Bool {
        guard lhs.type == rhs.type else {
            return false
        }
        guard lhs.color == rhs.color else {
            return false
        }
        guard lhs.width == rhs.width else {
            return false
        }
        return true
    }

}
