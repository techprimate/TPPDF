//
//  PDFLineType.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.02.2017.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

/// Different types of lines
public enum PDFLineType: String {
    /// No visible line
    case none

    /// Full line
    case full

    /**
     * Dashed Line
     *
     * Dash length and spacing is three times the line width
     */
    case dashed

    /**
     * Dotted Line
     *
     * Dot spacing is twice the line width
     */
    case dotted
}
