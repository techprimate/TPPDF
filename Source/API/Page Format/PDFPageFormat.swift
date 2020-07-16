//
//  PageFormat.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/16.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/**
 * Source for page sizes: https://www.papersizes.org
 * All sizes are calculated using 72 points/inch
 */
public enum PDFPageFormat: String, CaseIterable {

    /**
     Page formats mostly used in the USA
     */
    case usHalfLetter = "us.half-letter",
         usLetter = "us.letter",
         usLegal = "us.legal",
         usJuniorLegal = "us.junior-legal",
         usLedger = "us.ledger"

    /**
     Page formats according to the American National Standards Institute
     */
    case ansiA = "ansi.a",
         ansiB = "ansi.b",
         ansiC = "ansi.c",
         ansiD = "ansi.d",
         ansiE = "ansi.e"

    /**
     A-Series of paper standard DIN 476
     For more detail: https://en.wikipedia.org/wiki/Paper_size#A_series
     */
    case a0 = "a0",
         a1 = "a1",
         a2 = "a2",
         a3 = "a3",
         a4 = "a4",
         a5 = "a5",
         a6 = "a6",
         a7 = "a7",
         a8 = "a8",
         a9 = "a9",
         a10 = "a10"

    /**
     B-Series is the geometric mean of the A-series
     For more detail: https://en.wikipedia.org/wiki/Paper_size#B_series
     */
    case b0 = "b0",
         b1 = "b1",
         b2 = "b2",
         b3 = "b3",
         b4 = "b4",
         b5 = "b5",
         b6 = "b6",
         b7 = "b7",
         b8 = "b8",
         b9 = "b9",
         b10 = "b10"

    /**
     C-Series is ususally used for envelopes. Definition is written in ISO 269
     For more detail: https://en.wikipedia.org/wiki/Paper_size#C_series
     */
    case c0 = "c0",
         c1 = "c1",
         c2 = "c2",
         c3 = "c3",
         c4 = "c4",
         c5 = "c5",
         c6 = "c6",
         c7 = "c7",
         c8 = "c8",
         c9 = "c9",
         c10 = "c10"

    /**
     Size defined in constants
     */
    public var size: CGSize {
        switch self {
        case .usHalfLetter, .usLetter, .usLegal, .usJuniorLegal, .usLedger:
            return usSize
        case .ansiA, .ansiB, .ansiC, .ansiD, .ansiE:
            return ansiSize
        case .a0, .a1, .a2, .a3, .a4, .a5, .a6, .a7, .a8, .a9, .a10:
            return aSize
        case .b0, .b1, .b2, .b3, .b4, .b5, .b6, .b7, .b8, .b9, .b10:
            return bSize
        case .c0, .c1, .c2, .c3, .c4, .c5, .c6, .c7, .c8, .c9, .c10:
            return cSize
        }
    }

    /**
     Swaps height and width to create a landscape format
     */
    public var landscapeSize: CGSize {
        CGSize(width: size.height, height: size.width)
    }
}
