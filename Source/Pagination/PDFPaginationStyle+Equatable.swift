//
//  PDFPaginationStyle+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 04/11/2017.
//

/**
 TODO: Documentation
 */
extension PDFPaginationStyle: Equatable {

    /**
     TODO: Documentation
     */
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

        if case PDFPaginationStyle.customClosure(_) = lhs, case PDFPaginationStyle.customClosure(_) = rhs {
            // Always return false if a custom closure is used
            // https://stackoverflow.com/questions/24111984/how-do-you-test-functions-and-closures-for-equality
            return false
        }

        return false
    }

}
