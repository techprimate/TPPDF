//
//  PDFPaginationClosure.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 04/11/2017.
//

/**
 Closure for custom pagination formatting.

 - parameter page: `Int` - Current page number
 - parameter total: `Int` - Total amount of pages

 - returns: Formatted pagination string
 */
public typealias PDFPaginationClosure = (_ page: Int, _ total: Int) -> String
