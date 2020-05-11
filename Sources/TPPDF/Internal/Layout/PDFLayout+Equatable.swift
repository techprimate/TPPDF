//
//  PDFLayout+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//
import Foundation
import UIKit
import CoreGraphics

/**
 TODO: documentation
 */
extension PDFLayout: Equatable {

    /**
     TODO: documentation
     */
    public static func == (lhs: PDFLayout, rhs: PDFLayout) -> Bool {
        guard lhs.heights == rhs.heights else {
            return false
        }
        guard lhs.indentation == rhs.indentation else {
            return false
        }
        return true
    }
}
