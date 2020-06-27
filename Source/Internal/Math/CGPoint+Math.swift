//
//  CGPoint+Math.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 04/11/2017.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

extension CGPoint {

    /**
     Adds a vector to a point

     - parameter lhs: CGPoint
     - parameter rhs: CGVector

     - returns: Translated point
     */
    public static func + (lhs: CGPoint, rhs: CGVector) -> CGPoint {
        CGPoint(x: lhs.x + rhs.dx, y: lhs.y + rhs.dy)
    }

    /**
     Adds two points together, by adding their components.

     - parameter lhs: CGPoint
     - parameter rhs: CGPoint

     - returns: Added point
     */
    public static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    /**
     Subtracts two points from each other, by subtracting their components.

     - parameter lhs: CGPoint
     - parameter rhs: CGPoint

     - returns: Subtracted point
     */
    public static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }

    /**
     Adds a value to both components of a point

     - parameter lhs: Point
     - parameter value: Value

     - returns: Moved point
     */
    public static func + (lhs: CGPoint, value: CGFloat) -> CGPoint {
        CGPoint(x: lhs.x + value, y: lhs.y + value)
    }

}
