//
//  PDFListItemSymbol.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//
//

import Foundation

extension PDFListItem {
    
    public enum Symbol: RawRepresentable {
        case none
        case inherit
        case dot
        case dash
        case custom(value: String)
        case numbered(value: String?)
        
        var stringValue: String {
            switch self {
            case .dot:
                return "\u{00B7}"
            case .dash:
                return "-"
            default:
                return ""
            }
        }
        
        public typealias RawValue = String
        
        public var rawValue: String {
            switch self {
            case .none:
                return "none"
            case .inherit:
                return "inherit"
            case .dot:
                return "dot"
            case .dash:
                return "dash"
            case let .numbered(value):
                return "numbered|" + (value ?? "nil")
            case let .custom(value):
                return "custom|" + value
            }
        }
        
        public init?(rawValue: Symbol.RawValue) {
            switch rawValue {
            case "none":
                self = .none
                break
            case "inherit":
                self = .inherit
                break
            case "dot":
                self = .dot
                break
            case "dash":
                self = .dash
                break
            default:
                let comps = rawValue.components(separatedBy: "|")
                if comps.count == 2 {
                    switch comps[0] {
                    case "numbered":
                        self = .numbered(value: (comps[1] == "nil" ? nil : comps[1]))
                    case "custom":
                        self = .custom(value: comps[1])
                    default:
                        self = .none
                    }
                } else {
                    self = .none
                }
            }
        }
    }
}
