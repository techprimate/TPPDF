//
//  PDFPageFormat+Size.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/**
 This extension includes all size constnats defined by their corresponding standard.
 */
public extension PDFPageFormat {

    /**
     Returns the defined US paper size if this format is a US format.
     If it is not a US format, it will check other constants for correct size
     */
    var usSize: CGSize {
        switch self {
        case .usHalfLetter:
            return CGSize(width: 396, height: 612)   // 140  x 216  mm | 5.5  x 8.5  in
        case .usLetter:
            return CGSize(width: 612, height: 792)   // 216  x 279  mm | 8.5  x 11.0 in
        case .usLegal:
            return CGSize(width: 612, height: 1008)  // 216  x 356  mm | 8.5  x 14.0 in
        case .usJuniorLegal:
            return CGSize(width: 360, height: 576)   // 127  x 203  mm | 5.0  x 8.0  in
        case .usLedger:
            return CGSize(width: 792, height: 1224)  // 279  x 432  mm | 11.0 x 17.0 in
        default:
            return size
        }
    }

    /**
     Returns the defined ANSI paper size if this format is a ANSI format.
     If it is not a ANSI format, it will check other constants for correct size
     */
    var ansiSize: CGSize {
        switch self {
        case .ansiA:
            return CGSize(width: 612, height: 792)   // 216  x 279  mm | 8.5  x 11.0 in
        case .ansiB:
            return CGSize(width: 792, height: 1224)  // 279  x 432  mm | 11.0 x 17.0 in
        case .ansiC:
            return CGSize(width: 1224, height: 1584) // 432  x 559  mm | 17.0 x 22.0 in
        case .ansiD:
            return CGSize(width: 1584, height: 2448) // 559  x 864  mm | 22.0 x 34.0 in
        case .ansiE:
            return CGSize(width: 2448, height: 3168) // 864  x 1118 mm | 34.0 x 44.0 in
        default:
            return size
        }
    }

    /**
     Returns the defined A-Series paper size if this format is a A-Series format.
     If it is not a A-Series format, it will check other constants for correct size
     */
    var aSize: CGSize {
        switch self {
        case .a0:
            return CGSize(width: 2384, height: 3370) // 841  x 1189 mm | 33.1 x 46.8 in
        case .a1:
            return CGSize(width: 1684, height: 2384) // 594  x 841  mm | 23.4 x 33.1 in
        case .a2:
            return CGSize(width: 1191, height: 1684) // 420  x 594  mm | 16.5 x 23.4 in
        case .a3:
            return CGSize(width: 842, height: 1191)  // 297  x 420  mm | 11.7 x 16.5 in
        case .a4:
            return CGSize(width: 595, height: 842)   // 210  x 297  mm | 8.3  x 11.7 in
        case .a5:
            return CGSize(width: 420, height: 595)   // 148  x 210  mm | 5.8  x 8.3  in
        case .a6:
            return CGSize(width: 298, height: 420)   // 105  x 148  mm | 4.1  x 5.8  in
        case .a7:
            return CGSize(width: 210, height: 298)   // 74   x 105  mm | 2.9  x 4.1  in
        case .a8:
            return CGSize(width: 147, height: 210)   // 52   x 74   mm | 2.0  x 2.9  in
        case .a9:
            return CGSize(width: 105, height: 147)   // 37   x 52   mm | 1.5  x 2.0  in
        case .a10:
            return CGSize(width: 74, height: 105)    // 26   x 37   mm | 1.0  x 1.5  in
        default:
            return size
        }
    }

    /**
     Returns the defined B-Series paper size if this format is a B-Series format.
     If it is not a B-Series format, it will check other constants for correct size
     */
    var bSize: CGSize {
        switch self {
        case .b0:
            return CGSize(width: 2834, height: 4008) // 1000 x 1414 mm | 39.4 x 66.7 in
        case .b1:
            return CGSize(width: 2004, height: 2834) // 707  x 1000 mm | 27.8 x 39.4 in
        case .b2:
            return CGSize(width: 1417, height: 2004) // 500  x 707  mm | 19.7 x 27.8 in
        case .b3:
            return CGSize(width: 1001, height: 1417) // 353  x 500  mm | 13.9 x 19.7 in
        case .b4:
            return CGSize(width: 709, height: 1001)  // 250  x 353  mm | 9.8  x 13.9 in
        case .b5:
            return CGSize(width: 499, height: 709)   // 176  x 250  mm | 6.9  x 9.8  in
        case .b6:
            return CGSize(width: 354, height: 499)   // 125  x 176  mm | 4.9  x 6.9  in
        case .b7:
            return CGSize(width: 249, height: 354)   // 88   x 125  mm | 3.5  x 4.9  in
        case .b8:
            return CGSize(width: 176, height: 249)   // 62   x 88   mm | 2.4  x 3.5  in
        case .b9:
            return CGSize(width: 125, height: 176)   // 44   x 62   mm | 1.7  x 2.4  in
        case .b10:
            return CGSize(width: 88, height: 125)    // 31   x 44   mm | 1.2  x 1.7  in
        default:
            return size
        }
    }

    /**
     Returns the defined C-Series paper size if this format is a C-Series format.
     If it is not a C-Series format, it will check other constants for correct size
     */
    var cSize: CGSize {
        switch self {
        case .c0:
            return CGSize(width: 2599, height: 3677) // 917  x 1297 mm | 36.1 x 51.5 in
        case .c1:
            return CGSize(width: 1837, height: 2599) // 648  x 917  mm | 25.5 x 36.1 in
        case .c2:
            return CGSize(width: 1298, height: 1837) // 458  x 648  mm | 18.0 x 25.5 in
        case .c3:
            return CGSize(width: 918, height: 1298)  // 324  x 458  mm | 12.8 x 18.0 in
        case .c4:
            return CGSize(width: 649, height: 918)   // 229  x 324  mm | 9.0  x 12.8 in
        case .c5:
            return CGSize(width: 459, height: 649)   // 162  x 229  mm | 6.4  x 9.0  in
        case .c6:
            return CGSize(width: 323, height: 459)   // 114  x 162  mm | 4.5  x 6.4  in
        case .c7:
            return CGSize(width: 230, height: 323)   // 81   x 114  mm | 3.2  x 4.5  in
        case .c8:
            return CGSize(width: 162, height: 230)   // 57   x 81   mm | 2.2  x 3.2  in
        case .c9:
            return CGSize(width: 113, height: 162)   // 40   x 57   mm | 1.6  x 2.2  in
        case .c10:
            return CGSize(width: 79, height: 113)    // 28   x 40   mm | 1.1  x 1.6  in
        default:
            return size
        }
    }
}
