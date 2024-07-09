//
//  CGPoint+Math.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 04/11/2017.
//

#if os(iOS) || os(visionOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

public extension CGPoint {
    /**
     Adds a vector to a point

     - Parameter lhs: CGPoint
     - Parameter rhs: CGVector

     - Returns: Translated point
     */
    static func + (lhs: CGPoint, rhs: CGVector) -> CGPoint {
        CGPoint(x: lhs.x + rhs.dx, y: lhs.y + rhs.dy)
    }

    /**
     Adds two points together, by adding their components.

     - Parameter lhs: CGPoint
     - Parameter rhs: CGPoint

     - Returns: Added point
     */
    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    /**
     Subtracts two points from each other, by subtracting their components.

     - Parameter lhs: CGPoint
     - Parameter rhs: CGPoint

     - Returns: Subtracted point
     */
    static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }

    /**
     Adds a value to both components of a point

     - Parameter lhs: Point
     - Parameter value: Value

     - Returns: Moved point
     */
    static func + (lhs: CGPoint, value: CGFloat) -> CGPoint {
        CGPoint(x: lhs.x + value, y: lhs.y + value)
    }
}
