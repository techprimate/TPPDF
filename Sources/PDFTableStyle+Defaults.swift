//
//  PDFTableStyle+Defaults.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 19/01/2017.
//
//

import UIKit

public struct PDFTableStyleDefaults {
    
    public static let simple = TableStyle(
        rowHeaderCount: 1,
        columnHeaderCount: 1,
        footerCount: 0,
        
        outline: PDFLineStyle(
            type: .none
        ),
        rowHeaderStyle: TableCellStyle(
            fillColor: UIColor.white,
            textColor: UIColor(colorLiteralRed: 59.0 / 255.0, green: 59.0 / 255.0, blue: 59.0 / 255.0, alpha: 1.0),
            font: UIFont.boldSystemFont(ofSize: 12.0),
            
            borderLeft: PDFLineStyle(
                type: .none
            ),
            borderTop: PDFLineStyle(
                type: .none
            ),
            borderRight: PDFLineStyle(
                type: .none
            ),
            borderBottom: PDFLineStyle(
                type: .full,
                color: UIColor.lightGray,
                width: 0.5
            )
        ),
        columnHeaderStyle: TableCellStyle(
            fillColor: UIColor(colorLiteralRed: 83.0 / 255.0, green: 171.0 / 255.0, blue: 104.0 / 255.0, alpha: 1.0),
            textColor: UIColor.white,
            font: UIFont.boldSystemFont(ofSize: 14),
            
            borderLeft: PDFLineStyle(
                type: .none
            ),
            borderTop: PDFLineStyle(
                type: .none
            ),
            borderRight: PDFLineStyle(
                type: .none
            ),
            borderBottom: PDFLineStyle(
                type: .none
            )
        ),
        contentStyle: TableCellStyle(
            fillColor: UIColor(colorLiteralRed: 246.0 / 255.0, green: 246.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0),
            textColor: UIColor(colorLiteralRed: 59.0 / 255.0, green: 59.0 / 255.0, blue: 59.0 / 255.0, alpha: 1.0),
            font: UIFont.systemFont(ofSize: 14),
            
            borderLeft: PDFLineStyle(
                type: .none
            ),
            borderTop: PDFLineStyle(
                type: .none
            ),
            borderRight: PDFLineStyle(
                type: .none
            ),
            borderBottom: PDFLineStyle(
                type: .none
            )
        ),
        alternatingContentStyle: TableCellStyle(
            fillColor: UIColor(colorLiteralRed: 233.0 / 255.0, green: 233.0 / 255.0, blue: 233.0 / 255.0, alpha: 1.0),
            textColor: UIColor(colorLiteralRed: 59.0 / 255.0, green: 59.0 / 255.0, blue: 59.0 / 255.0, alpha: 1.0),
            font: UIFont.systemFont(ofSize: 14),
            
            borderLeft: PDFLineStyle(
                type: .none
            ),
            borderTop: PDFLineStyle(
                type: .none
            ),
            borderRight: PDFLineStyle(
                type: .none
            ),
            borderBottom: PDFLineStyle(
                type: .none
            )
        )
    )
}
