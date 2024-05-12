//
//  PDFPaginationStyle+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 04/11/2017.
//

extension PDFPaginationStyle: Equatable {
    /// nodoc
    public static func == (lhs: PDFPaginationStyle, rhs: PDFPaginationStyle) -> Bool {
        if case PDFPaginationStyle.default = lhs, case PDFPaginationStyle.default = rhs {
            return true
        }

        if case let PDFPaginationStyle.roman(lhsTemplate) = lhs, case let PDFPaginationStyle.roman(rhsTemplate) = rhs {
            return lhsTemplate == rhsTemplate
        }

        if case let PDFPaginationStyle.customNumberFormat(lhsTemplate, lhsFormatter) = lhs,
           case let PDFPaginationStyle.customNumberFormat(rhsTemplate, rhsFormatter) = rhs {
            return lhsTemplate == rhsTemplate && lhsFormatter == rhsFormatter
        }

        if case PDFPaginationStyle.customClosure = lhs, case PDFPaginationStyle.customClosure = rhs {
            // Always return false if a custom closure is used, because closures can not be equated
            // Reference: https://stackoverflow.com/questions/24111984/how-do-you-test-functions-and-closures-for-equality
            return false
        }

        return false
    }
}
