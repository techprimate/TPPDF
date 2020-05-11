//
//  PDFOffsetObject+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 14/11/2017.
//
import Foundation
import UIKit
import CoreGraphics

/**
 TODO: documentation
 */
extension PDFOffsetObject: Equatable {

    /**
     TODO: documentation
     */
    public static func == (lhs: PDFOffsetObject, rhs: PDFOffsetObject) -> Bool {
        guard lhs.offset == rhs.offset else {
            return false
        }
        return true
    }
}
