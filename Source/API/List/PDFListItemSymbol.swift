//
//  PDFListItemSymbol.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//

/// Symbol used by a list item in a ``PDFList``
public enum PDFListItemSymbol: RawRepresentable, Hashable {
    /// nodoc
    public typealias RawValue = String

    /// Doesn't display a symbol before the content
    case none

    /// If an item is nested and uses this symbol, it will take the same one as the parent.
    case inherit

    /// Symbol is a middle-dot
    case dot

    /// Symbol is a dash/minus.
    case dash

    /**
     * Any string `value` must be provided, which will then be used as the symbol.
     *
     * The indentation value of the ``PDFList`` must be set correctly in the initializer ``PDFList/init(indentations:)``,
     * as the indentation is not based on the symbol frame width.
     */
    case custom(value: String)

    /**
     * When the parent of multiple list items is of type `numbered`, it will then use the index as the symbol, starting with `1` and
     * append a dot `.` to the number.
     *
     * If a `value` is provided, this will be used for the parent item, in case you want to override the value.
     */
    case numbered(value: String?)

    /// Returns the symbol as a string, to be calculated and rendered using ``PDFText``
    public var stringValue: String {
        switch self {
        case .dot:
            return "\u{00B7}"
        case .dash:
            return "-"
        case let .numbered(value):
            return (value ?? "?") + "."
        case let .custom(value):
            return value
        default:
            return ""
        }
    }

    /// nodoc
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

    /// nodoc
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
                    self = .numbered(value: comps[1] == "nil" ? nil : comps[1])
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

    /// nodoc
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

    /// nodoc
    public func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}
