//
//  PDFTextStyle.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 28.05.19.
//

import Foundation
import UIKit

/**
 TODO: Documentation
 */
public class PDFTextStyle {

    /**
     Name of style
     */
    public var name: String

    /**
     Font of object
     */
    public var font: UIFont?

    /**
     Text color of object
     */
    public var color: UIColor?

    /**
     Initalizer

     - parameter name: Name of style
     - parameter font: Font of text, defaults to nil
     - parameter color: Color of text, defaults to nil
     */
    public init(name: String, font: UIFont? = nil, color: UIColor? = nil) {
        self.name = name
        self.font = font
        self.color = color
    }
}
