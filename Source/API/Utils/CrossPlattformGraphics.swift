//
//  CrossPlattformGraphics.swift
//
//
//  Created by Philip Niedertscheider on 19.05.20.
//

#if os(iOS)

import UIKit

public typealias Color = UIColor
public typealias Font = UIFont
public typealias Image = UIImage
public typealias EdgeInsets = UIEdgeInsets
public typealias BezierPath = UIBezierPath
public typealias Point = CGPoint
public typealias RectCorner = UIRectCorner

#elseif os(macOS)

import AppKit

public typealias Color = NSColor
public typealias Font = NSFont
public typealias Image = NSImage
public typealias EdgeInsets = NSEdgeInsets
public typealias BezierPath = NSBezierPath
public typealias Point = NSPoint

extension NSBezierPath{
    func quadCurve(to endPoint: CGPoint, controlPoint: CGPoint) {
        let startPoint = self.currentPoint
        let controlPoint1 = CGPoint(x: (startPoint.x + (controlPoint.x - startPoint.x) * 2.0/3.0), y: (startPoint.y + (controlPoint.y - startPoint.y) * 2.0/3.0))
        let controlPoint2 = CGPoint(x: (endPoint.x + (controlPoint.x - endPoint.x) * 2.0/3.0), y: (endPoint.y + (controlPoint.y - endPoint.y) * 2.0/3.0))
        curve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
    }
}

extension NSEdgeInsets {

    public static var zero: NSEdgeInsets {
        NSEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension NSEdgeInsets: Equatable {

    public static func == (lhs: NSEdgeInsets, rhs: NSEdgeInsets) -> Bool {
        lhs.top == rhs.top && lhs.left == rhs.left && lhs.bottom == rhs.bottom && lhs.right == rhs.right
    }
}

public struct RectCorner: OptionSet {

    public static var topLeft: RectCorner     = RectCorner(rawValue: 1 << 0)
    public static var topRight: RectCorner    = RectCorner(rawValue: 1 << 1)
    public static var bottomLeft: RectCorner  = RectCorner(rawValue: 1 << 2)
    public static var bottomRight: RectCorner = RectCorner(rawValue: 1 << 3)
    public static var allCorners: RectCorner  = RectCorner(rawValue: 1 << 4)

    let value: Int

    public init(rawValue: Int) {
        self.value = rawValue
    }

    public var rawValue: Int {
        value
    }
}

extension CGRect {

    func inset(by inset: EdgeInsets) -> CGRect {
        CGRect(x: self.minX + inset.left,
               y: self.minY + inset.top,
               width: self.width - inset.left - inset.right,
               height: self.height - inset.top - inset.bottom)
    }
}

extension NSBezierPath {

    var cgPath: CGPath {
        let path = CGMutablePath()
        var points = [CGPoint](repeating: .zero, count: 3)
        for i in 0 ..< self.elementCount {
            let type = self.element(at: i, associatedPoints: &points)

            switch type {
            case .moveTo:
                path.move(to: points[0])

            case .lineTo:
                path.addLine(to: points[0])

            case .curveTo:
                path.addCurve(to: points[2], control1: points[0], control2: points[1])

            case .closePath:
                path.closeSubpath()

            @unknown default:
                break
            }
        }
        return path
    }
}


extension NSBezierPath {

    convenience init(roundedRect rect: CGRect, byRoundingCorners corners: RectCorner, cornerRadii: CGSize) {
        var path = CGMutablePath()

        let topLeft = rect.origin;
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)

        if corners.contains(.topLeft) {
            path.move(to: CGPoint(x: topLeft.x + cornerRadii.width, y: topLeft.y))
        } else {
            path.move(to: topLeft)
        }

        if corners.contains(.topRight) {
            path.addLine(to: CGPoint(x: topRight.x - cornerRadii.width, y: topRight.y))
            path.addQuadCurve(to: CGPoint(x: topRight.x, y: topRight.y + cornerRadii.height), control: topRight)
        } else {
            path.addLine(to: topRight)
        }

        if corners.contains(.bottomRight) {
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y - cornerRadii.height))
            path.addQuadCurve(to: CGPoint(x: bottomRight.x - cornerRadii.width, y: bottomRight.y), control: bottomRight)
        } else {
            path.addLine(to: bottomRight)
        }

        if corners.contains(.bottomLeft) {
            path.addLine(to: CGPoint(x: bottomLeft.x + cornerRadii.width, y: bottomLeft.y))
            path.addQuadCurve(to: CGPoint(x: bottomLeft.x, y: bottomRight.y - cornerRadii.height), control: bottomLeft)
        } else {
            path.addLine(to: bottomLeft)
        }

        if corners.contains(.topLeft) {
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y - cornerRadii.height))
            path.addQuadCurve(to: CGPoint(x: topLeft.x + cornerRadii.width, y: topLeft.y), control: topLeft)
        } else {
            path.addLine(to: topLeft)
        }

        path.closeSubpath()

        self.init(path: path)
    }
}

extension NSImage {

    func jpegData(compressionQuality quality: CGFloat) -> Data? {
        return self.tiffRepresentation(using: .jpeg, factor: Float(quality))
    }
}

extension NSBezierPath {

    convenience init(path: CGPath) {
        self.init()

        var bezierPath = NSBezierPath()
        
        let pathPtr = UnsafeMutablePointer<NSBezierPath>(1)
        pathPtr.initialize(self)

        let infoPtr = UnsafeMutablePointer<Void>(pathPtr)

        // I hope the CGPathApply call manages the deallocation of the pointers passed to the applier
        // function, but I'm not sure.
        CGPathApply(path, infoPtr) { (infoPtr, elementPtr) -> Void in
            let path = UnsafeMutablePointer<NSBezierPath>(infoPtr).memory
            let element = elementPtr.memory

            let pointsPtr = element.points

            switch element.type {
            case .MoveToPoint:
                path.moveToPoint(pointsPtr.memory)

            case .AddLineToPoint:
                path.lineToPoint(pointsPtr.memory)

            case .AddQuadCurveToPoint:
                let firstPoint = pointsPtr.memory
                let secondPoint = pointsPtr.successor().memory

                let currentPoint = path.currentPoint
                let x = (currentPoint.x + 2 * firstPoint.x) / 3
                let y = (currentPoint.y + 2 * firstPoint.y) / 3
                let interpolatedPoint = CGPoint(x: x, y: y)

                let endPoint = secondPoint

                path.curveToPoint(endPoint, controlPoint1: interpolatedPoint, controlPoint2: interpolatedPoint)

            case .AddCurveToPoint:
                let firstPoint = pointsPtr.memory
                let secondPoint = pointsPtr.successor().memory
                let thirdPoint = pointsPtr.successor().successor().memory

                path.curveToPoint(thirdPoint, controlPoint1: firstPoint, controlPoint2: secondPoint)

            case .CloseSubpath:
                path.closePath()
            }

            pointsPtr.destroy()
        }
    }

    // TODO: Add conversion to CGPath

}
#endif
