//
//  PDFTextStyle.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 28.05.19.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/**
 TODO: Documentation
 */
public class PDFTextStyle: Hashable {

    /**
     Name of style
     */
    public var name: String

    /**
     Font of object
     */
    public var font: Font?

    /**
     Text color of object
     */
    public var color: Color?

    /**
     Initalizer

     - parameter name: Name of style
     - parameter font: Font of text, defaults to nil
     - parameter color: Color of text, defaults to nil
     */
    public init(name: String, font: Font? = nil, color: Color? = nil) {
        self.name = name
        self.font = font
        self.color = color
    }

    // MARK: - Equatable

    public static func == (lhs: PDFTextStyle, rhs: PDFTextStyle) -> Bool {
        guard lhs.name == rhs.name else {
            return false
        }
        guard lhs.font == rhs.font else {
            return false
        }
        guard lhs.color == rhs.color else {
            return false
        }
        return true
    }

    // MARK: - Hashable

    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(font)
        hasher.combine(color)
    }
}
