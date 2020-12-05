//
//  PDFListItemSymbol.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//

/**
 TODO: documentation
 */
public enum PDFListItemSymbol: RawRepresentable, Hashable {

    /**
     TODO: documentation
     */
    public typealias RawValue = String

    /**
     TODO: documentation
     */
    case none

    /**
     TODO: documentation
     */
    case inherit

    /**
     TODO: documentation
     */
    case dot

    /**
     TODO: documentation
     */
    case dash

    /**
     TODO: documentation
     */
    case custom(value: String)

    /**
     TODO: documentation
     */
    case numbered(value: String?)

    /**
     TODO: documentation
     */
    public var stringValue: String {
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

    /**
     TODO: documentation
     */
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

    /**
     TODO: documentation
     */
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

    // MARK: - Equatable

    public static func == (lhs: PDFListItemSymbol, rhs: PDFListItemSymbol) -> Bool {
        switch (lhs, rhs) {
        case (.none, .none),
             (.inherit, .inherit),
             (.dot, .dot),
             (.dash, .dash):
            return true
        case let (.custom(lhsValue), .custom(rhsValue)):
            return lhsValue == rhsValue
        case let (.numbered(lhsValue), .numbered(rhsValue)):
            return lhsValue == rhsValue
        default:
            return false
        }
    }

    // MARK: - Hashable

    public func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}
