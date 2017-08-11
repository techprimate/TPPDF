//
//  PageFormat.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/16.
//
//

import UIKit

/**
 * Source for page sizes: https://www.papersizes.org
 * All sizes are calculated using 72 points/inch
 */
public enum PDFPageFormat {
    
    case usHalfLetter, usLetter, usLegal, usJuniorLegal, usLedger
    case ansiA, ansiB, ansiC, ansiD, ansiE
    
    case a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10
    case b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, b10
    case c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10
    
    var size: CGSize {
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
        
    var landscapeSize: CGSize {
        return CGSize(width: self.size.height, height: self.size.width)
    }
}
