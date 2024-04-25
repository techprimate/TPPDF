//
//  PDFLineType.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 02/11/2017.
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
