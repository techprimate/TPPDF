//
//  PDFPageFormat+Margin.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//
//

import Foundation

public extension PDFPageFormat {
    
    var headerMargin: CGFloat {
        switch self {
        case .usHalfLetter, .usLetter, .usLegal, .usJuniorLegal, .usLedger,
             .ansiA, .ansiB, .ansiC, .ansiD, .ansiE,
             .a0, .a1, .a2, .a3, .a4, .a5, .a6, .a7, .a8, .a9, .a10,
             .b0, .b1, .b2, .b3, .b4, .b5, .b6, .b7, .b8, .b9, .b10,
             .c0, .c1, .c2, .c3, .c4, .c5, .c6, .c7, .c8, .c9, .c10:
            return 30.0
        }
    }
    
    var footerMargin: CGFloat {
        switch self {
        case .usHalfLetter, .usLetter, .usLegal, .usJuniorLegal, .usLedger,
             .ansiA, .ansiB, .ansiC, .ansiD, .ansiE,
             .a0, .a1, .a2, .a3, .a4, .a5, .a6, .a7, .a8, .a9, .a10,
             .b0, .b1, .b2, .b3, .b4, .b5, .b6, .b7, .b8, .b9, .b10,
             .c0, .c1, .c2, .c3, .c4, .c5, .c6, .c7, .c8, .c9, .c10:
            return 30.0
        }
    }
    
    var margin: CGFloat {
        switch self {
        case .usHalfLetter, .usLetter, .usLegal, .usJuniorLegal, .usLedger,
             .ansiA, .ansiB, .ansiC, .ansiD, .ansiE,
             .a0, .a1, .a2, .a3, .a4, .a5, .a6, .a7, .a8, .a9, .a10,
             .b0, .b1, .b2, .b3, .b4, .b5, .b6, .b7, .b8, .b9, .b10,
             .c0, .c1, .c2, .c3, .c4, .c5, .c6, .c7, .c8, .c9, .c10:
            return 60.0
        }
    }
    
    var headerSpace: CGFloat {
        switch self {
        case .usHalfLetter, .usLetter, .usLegal, .usJuniorLegal, .usLedger,
             .ansiA, .ansiB, .ansiC, .ansiD, .ansiE,
             .a0, .a1, .a2, .a3, .a4, .a5, .a6, .a7, .a8, .a9, .a10,
             .b0, .b1, .b2, .b3, .b4, .b5, .b6, .b7, .b8, .b9, .b10,
             .c0, .c1, .c2, .c3, .c4, .c5, .c6, .c7, .c8, .c9, .c10:
            return 15.0
        }
    }
    
    var footerSpace: CGFloat {
        switch self {
        case .usHalfLetter, .usLetter, .usLegal, .usJuniorLegal, .usLedger,
             .ansiA, .ansiB, .ansiC, .ansiD, .ansiE,
             .a0, .a1, .a2, .a3, .a4, .a5, .a6, .a7, .a8, .a9, .a10,
             .b0, .b1, .b2, .b3, .b4, .b5, .b6, .b7, .b8, .b9, .b10,
             .c0, .c1, .c2, .c3, .c4, .c5, .c6, .c7, .c8, .c9, .c10:
            return 15.0
        }
    }
}
