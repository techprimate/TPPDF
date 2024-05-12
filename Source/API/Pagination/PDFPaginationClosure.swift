//
//  PDFPaginationClosure.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 04/11/2017.
//

/**
 * Closure for custom pagination formatting.
 *
 * - Parameter page: `Int` - Current page number
 * - Parameter total: `Int` - Total amount of pages
 *
 * - Returns: Formatted pagination string
 */
public typealias PDFPaginationClosure = (_ page: Int, _ total: Int) -> String
