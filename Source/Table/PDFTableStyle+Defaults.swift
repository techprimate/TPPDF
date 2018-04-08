//
//  PDFTableStyle+Defaults.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 19/01/2017.
//

/**
 A collection of table style defaults
 */
public struct PDFTableStyleDefaults {

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
        let darkGray = UIColor(red: 59.0 / 255.0, green: 59.0 / 255.0, blue: 59.0 / 255.0, alpha: 1.0)
        let invisibleBorders = PDFTableCellBorders()

        return PDFTableStyle(
            rowHeaderCount: 1,
            columnHeaderCount: 1,
            footerCount: 0,

            outline: PDFLineStyle(type: .full, color: UIColor.darkGray, width: 1.0),
            rowHeaderStyle: PDFTableCellStyle(
                colors: (fill: UIColor.white, text: darkGray),
                borders: PDFTableCellBorders(bottom: PDFLineStyle(
                            type: .full,
                            color: UIColor.lightGray,
                            width: 0.5
                )),
                font: UIFont.boldSystemFont(ofSize: 12.0)
            ),
            columnHeaderStyle: PDFTableCellStyle(
                colors: (
                    fill: UIColor(red: 83.0 / 255.0, green: 171.0 / 255.0, blue: 104.0 / 255.0, alpha: 1.0),
                    text: UIColor.white
                ),
                borders: invisibleBorders,
                font: UIFont.boldSystemFont(ofSize: 14)
            ),
            contentStyle: PDFTableCellStyle(
                colors: (
                    fill: UIColor(red: 246.0 / 255.0, green: 246.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0),
                    text: darkGray
                ),
                borders: invisibleBorders,
                font: UIFont.systemFont(ofSize: 14)
            ),
            alternatingContentStyle: PDFTableCellStyle(
                colors: (
                    fill: UIColor(red: 233.0 / 255.0, green: 233.0 / 255.0, blue: 233.0 / 255.0, alpha: 1.0),
                    text: darkGray
                ),
                borders: invisibleBorders,
                font: UIFont.systemFont(ofSize: 14)
            )
        )
    }
}
