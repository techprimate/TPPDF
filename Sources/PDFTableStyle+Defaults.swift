//
//  PDFTableStyle+Defaults.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 19/01/2017.
//
//

public struct PDFTableStyleDefaults {
    
    public static var simple: PDFTableStyle {
        let darkGray = UIColor(colorLiteralRed: 59.0 / 255.0, green: 59.0 / 255.0, blue: 59.0 / 255.0, alpha: 1.0)
        let invisibleBorders = (left: PDFLineStyle.none,
                                top: PDFLineStyle.none,
                                right: PDFLineStyle.none,
                                bottom: PDFLineStyle.none)
        
        return PDFTableStyle(
            rowHeaderCount: 1,
            columnHeaderCount: 1,
            footerCount: 0,
            
            outline: PDFLineStyle(
                type: .none
            ),
            rowHeaderStyle: PDFTableCellStyle(
                colors: (fill: UIColor.white, text: darkGray),
                borders: (left: PDFLineStyle.none,
                         top: PDFLineStyle.none,
                         right: PDFLineStyle.none,
                         bottom: PDFLineStyle(
                            type: .full,
                            color: UIColor.lightGray,
                            width: 0.5
                )),
                font: UIFont.boldSystemFont(ofSize: 12.0)
            ),
            columnHeaderStyle: PDFTableCellStyle(
                colors: (
                    fill: UIColor(colorLiteralRed: 83.0 / 255.0, green: 171.0 / 255.0, blue: 104.0 / 255.0, alpha: 1.0),
                    text: UIColor.white
                ),
                borders: invisibleBorders,
                font: UIFont.boldSystemFont(ofSize: 14)
            ),
            contentStyle: PDFTableCellStyle(
                colors: (
                    fill: UIColor(colorLiteralRed: 246.0 / 255.0, green: 246.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0),
                    text: darkGray
                ),
                borders: invisibleBorders,
                font: UIFont.systemFont(ofSize: 14)
            ),
            alternatingContentStyle: PDFTableCellStyle(
                colors: (
                    fill: UIColor(colorLiteralRed: 233.0 / 255.0, green: 233.0 / 255.0, blue: 233.0 / 255.0, alpha: 1.0),
                    text: darkGray
                ),
                borders: invisibleBorders,
                font: UIFont.systemFont(ofSize: 14)
            )
        )
    }
}
