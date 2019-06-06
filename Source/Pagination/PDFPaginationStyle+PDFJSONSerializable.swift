//
//  PDFPaginationStyle+PDFJSONSerializable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 30.05.19.
//

import Foundation

// MARK: - JSON Serialization

extension PDFPaginationStyle: PDFJSONSerializable {

    /**
     Creates a representable object
     */
    public var JSONRepresentation: AnyObject {
        let result: String = {
            switch self {
            case .default:
                return "PDFPaginationStyle.default"
            case .roman(let template):
                return "PDFPaginationStyle.roman(" + template + ")"
            case .customNumberFormat(let template, _):
                return "PDFPaginationStyle.customNumberFormat(" + template + ")"
            case .customClosure:
                return "PDFPaginationStyle.customClosure"
            }
        }()
        return result as AnyObject
    }
}
