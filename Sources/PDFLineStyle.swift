//
//  PDFLineStyle.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//
//

/// This struct defines how a line or border of a table is drawn.
public struct PDFLineStyle : TPJSONSerializable {
    
    /// These types of lines are available for rendering. Used in `PDFTableStyle` and `PDFTableCellStyle`
    ///
    /// - full: Line without any breaks
    /// - dashed: Line consists out of short dashes
    /// - dotted: Lines consists out of dots
    public enum LineType : TPJSONSerializable {
        
        case none, full, dashed, dotted
        
        // MARK: - JSON Serialization
        
        public var JSONRepresentation: AnyObject {
            return self.hashValue as AnyObject
        }
    }
    
    /// Defines the type of this line
    public var type: LineType
    /// Defines the color of this line
    public var color: UIColor
    /// Defines the width of this line
    public var width: Double
    
    /// Initialize a table line style
    ///
    /// - Parameters:
    ///   - type: of Line
    ///   - color: of Line
    ///   - width: of Line
    public init(type: LineType = .full, color: UIColor = UIColor.black, width: Double = 0.25) {
        self.type = type
        self.color = color
        self.width = width
    }
    
    /// Shorthand method for creating an invisible line
    public static var none: PDFLineStyle {
        return PDFLineStyle(type: .none)
    }
}
