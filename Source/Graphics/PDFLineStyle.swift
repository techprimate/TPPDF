//
//  PDFLineStyle.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//

/**
 This struct defines how a line or border of a table is drawn.
 */
public struct PDFLineStyle: PDFJSONSerializable {

    /**
     Defines the type of this line
     */
    public var type: PDFLineType

    /**
     Defines the color of this line
     */
    public var color: UIColor

    /**
     Defines the width of this line
     */
    public var width: CGFloat

    /**
     Initialize a table line style

     - parameter type: of Line
     - parameter color: of Line
     - parameter width: of Line
     */
    public init(type: PDFLineType = .full, color: UIColor = .black, width: CGFloat = 0.25) {
        self.type = type
        self.color = color
        self.width = width
    }

    /**
     Shorthand method for creating an invisible line
     */
    public static var none: PDFLineStyle {
        return PDFLineStyle(type: .none, width: 0)
    }
}
