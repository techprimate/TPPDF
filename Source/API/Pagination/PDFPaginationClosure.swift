//
//  PDFPaginationClosure.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.04.2017.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
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
