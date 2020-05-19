//
//  PDFTableStyle+Defaults.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 19/01/2017.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/**
 A collection of table style defaults
 */
public enum PDFTableStyleDefaults {

    /**
     None:

     - No header rows
     - No header columns
     - No footer row
     - No alternating rows
     - Simple outline
     - Simple borders
     */
    public static var none: PDFTableStyle {
        PDFTableStyle(
            rowHeaderCount: 0,
            columnHeaderCount: 0,
            footerCount: 0,
            outline: PDFLineStyle(),
            rowHeaderStyle: PDFTableCellStyle(),
            columnHeaderStyle: PDFTableCellStyle(),
            footerStyle: PDFTableCellStyle(),
            contentStyle: PDFTableCellStyle(
                borders: PDFTableCellBorders(
                    left: PDFLineStyle(type: .full, color: .black, width: 1),
                    top: PDFLineStyle(type: .full, color: .black, width: 1),
                    right: PDFLineStyle(type: .full, color: .black, width: 1),
                    bottom: PDFLineStyle(type: .full, color: .black, width: 1))),
            alternatingContentStyle: nil)
    }
    /**
     Simple table:

     - One header row
     - One header column
     - Row Header:
     - Text color white
     - No border, only light gray border at bottom
     - Column Header:
     - Bold font
     - Alternating content rows
     */
    public static var simple: PDFTableStyle {
        let darkGray = Color(red: 59.0 / 255.0, green: 59.0 / 255.0, blue: 59.0 / 255.0, alpha: 1.0)
        let invisibleBorders = PDFTableCellBorders()

        return PDFTableStyle(
            rowHeaderCount: 1,
            columnHeaderCount: 1,
            footerCount: 0,

            outline: PDFLineStyle(type: .full, color: Color.darkGray, width: 1.0),
            rowHeaderStyle: PDFTableCellStyle(
                colors: (fill: Color.white, text: darkGray),
                borders: PDFTableCellBorders(bottom: PDFLineStyle(
                    type: .full,
                    color: Color.lightGray,
                    width: 0.5
                )),
                font: Font.boldSystemFont(ofSize: 12.0)
            ),
            columnHeaderStyle: PDFTableCellStyle(
                colors: (
                    fill: Color(red: 83.0 / 255.0, green: 171.0 / 255.0, blue: 104.0 / 255.0, alpha: 1.0),
                    text: Color.white
                ),
                borders: invisibleBorders,
                font: Font.boldSystemFont(ofSize: 14)
            ),
            contentStyle: PDFTableCellStyle(
                colors: (
                    fill: Color(red: 246.0 / 255.0, green: 246.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0),
                    text: darkGray
                ),
                borders: invisibleBorders,
                font: Font.systemFont(ofSize: 14)
            ),
            alternatingContentStyle: PDFTableCellStyle(
                colors: (
                    fill: Color(red: 233.0 / 255.0, green: 233.0 / 255.0, blue: 233.0 / 255.0, alpha: 1.0),
                    text: darkGray
                ),
                borders: invisibleBorders,
                font: Font.systemFont(ofSize: 14)
            )
        )
    }
}
