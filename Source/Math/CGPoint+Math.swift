//
//  CGPoint+Math.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 04/11/2017.
//

/**
 Adds two points together, by adding their components.

 - parameter lhs: CGPoint
 - parameter rhs: CGPoint

 - returns: Added point
 */
public func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

/**
 Subtracts two points from each other, by subtracting their components.

 - parameter lhs: CGPoint
 - parameter rhs: CGPoint

 - returns: Subtracted point
 */
public func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

/**
 Adds a value to both components of a point

 - parameter lhs: Point
 - parameter value: Value

 - returns: Moved point
 */
public func + (lhs: CGPoint, value: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x + value, y: lhs.y + value)
}
