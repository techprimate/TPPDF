//
//  PDFList+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

extension PDFList: Equatable {

    public static func == (lhs: PDFList, rhs: PDFList) -> Bool {
        if lhs.items != rhs.items {
            return false
        }

        for lhsItem in lhs.items {
            if !rhs.items.contains(lhsItem) {
                return false
            }
        }
        
        return true
    }
}
