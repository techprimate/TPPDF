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
        
        outline: TableLineStyle(
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
        )
    )
}
