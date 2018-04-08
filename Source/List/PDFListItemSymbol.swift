//
//  PDFListItemSymbol.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//

public enum PDFListItemSymbol: RawRepresentable, PDFJSONSerializable {

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
        case .numbered(let value):
            return (value ?? "?") + "."
        case .custom(let value):
            return value
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

    public init?(rawValue: PDFListItemSymbol.RawValue) {
        switch rawValue {
        case "none":
            self = .none
        case "inherit":
            self = .inherit
        case "dot":
            self = .dot
        case "dash":
            self = .dash
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

    public var JSONRepresentation: AnyObject {
        return self.rawValue as AnyObject
    }
}
