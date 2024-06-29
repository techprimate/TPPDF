#if os(iOS) || os(visionOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

/**
 This extension includes all name constants defined by their corresponding standard.
 Source for names: https://www.papersizes.org
 */
public extension PDFPageFormat {
    /**
     * Returns the defined US names if this format is a US format.
     *
     * If it is not a US format, it will check other constants for correct name
     */
    var usName: String {
        switch self {
        case .usHalfLetter:
            return "US Half Letter"
        case .usLetter:
            return "US Letter"
        case .usLegal:
            return "US Legal"
        case .usJuniorLegal:
            return "US Junior Legal"
        case .usLedger:
            return "US Ledger"
        default:
            return name
        }
    }

    /**
     * Returns the defined ANSI name if this format is a ANSI format.
     *
     * If it is not a ANSI format, it will check other constants for correct name
     */
    var ansiName: String {
        switch self {
        case .ansiA:
            return "ANSI A"
        case .ansiB:
            return "ANSI B"
        case .ansiC:
            return "ANSI C"
        case .ansiD:
            return "ANSI D"
        case .ansiE:
            return "ANSI E"
        default:
            return name
        }
    }

    /**
     * Returns the defined A-Series name if this format is a A-Series format.
     *
     * If it is not a A-Series format, it will check other constants for correct name
     */
    var aName: String {
        switch self {
        case .a0:
            return "A0"
        case .a1:
            return "A1"
        case .a2:
            return "A2"
        case .a3:
            return "A3"
        case .a4:
            return "A4"
        case .a5:
            return "A5"
        case .a6:
            return "A6"
        case .a7:
            return "A7"
        case .a8:
            return "A8"
        case .a9:
            return "A9"
        case .a10:
            return "A10"
        default:
            return name
        }
    }

    /**
     * Returns the defined B-Series name if this format is a B-Series format.
     *
     * If it is not a B-Series format, it will check other constants for correct name
     */
    var bName: String {
        switch self {
        case .b0:
            return "B0"
        case .b1:
            return "B1"
        case .b2:
            return "B2"
        case .b3:
            return "B3"
        case .b4:
            return "B4"
        case .b5:
            return "B5"
        case .b6:
            return "B6"
        case .b7:
            return "B7"
        case .b8:
            return "B8"
        case .b9:
            return "B9"
        case .b10:
            return "B10"
        default:
            return name
        }
    }

    /**
     * Returns the defined C-Series name if this format is a C-Series format.
     *
     * If it is not a C-Series format, it will check other constants for correct name
     */
    var cName: String {
        switch self {
        case .c0:
            return "C0"
        case .c1:
            return "C1"
        case .c2:
            return "C2"
        case .c3:
            return "C3"
        case .c4:
            return "C4"
        case .c5:
            return "C5"
        case .c6:
            return "C6"
        case .c7:
            return "C7"
        case .c8:
            return "C8"
        case .c9:
            return "C9"
        case .c10:
            return "C10"
        default:
            return name
        }
    }
}
