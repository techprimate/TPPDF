//
//  TableStyle+Defaults.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 19/01/2017.
//
//

import UIKit

public struct TableStyleDefaults {
    
    public static let simple = TableStyle(
        rowHeaderCount: 1,
        columnHeaderCount: 1,
        footerCount: 1,
        
        outline: LineStyle(
            type: .full,
            color: UIColor.lightGray,
            width: 0.25
        ),
        
        rowHeaderStyle: TableCellStyle(
            fillColor: UIColor.gray,
            textColor: UIColor.blue,
            font: UIFont.boldSystemFont(ofSize: 11)
        ),
        columnHeaderStyle: TableCellStyle(
            fillColor: UIColor.lightGray,
            textColor: UIColor.green,
            font: UIFont.systemFont(ofSize: 15)
        ),
        footerStyle: TableCellStyle(
            fillColor: UIColor.darkGray,
            textColor: UIColor.red,
            font: UIFont.italicSystemFont(ofSize: 20)
        ),
        contentStyle: TableCellStyle(
            fillColor: UIColor.red,
            textColor: UIColor.green,
            font: UIFont.systemFont(ofSize: 16),
            
            borderLeft: LineStyle(
                type: .full,
                color: UIColor.purple,
                width: 1.0
            ),
            borderTop: LineStyle(
                type: .full,
                color: UIColor.purple,
                width: 1.0
            ),
            borderRight: LineStyle(
                type: .full,
                color: UIColor.purple,
                width: 1.0
            ),
            borderBottom: LineStyle(
                type: .full,
                color: UIColor.purple,
                width: 1.0
            )
        ),
        alternatingContentStyle: TableCellStyle(
            fillColor: UIColor.green,
            textColor: UIColor.red,
            font: UIFont.systemFont(ofSize: 20)
        )
    )
}
