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

extension NSBezierPath {
    func quadCurve(to endPoint: CGPoint, controlPoint: CGPoint) {
        let startPoint = self.currentPoint
        let controlPoint1 = CGPoint(x: (startPoint.x + (controlPoint.x - startPoint.x) * 2.0/3.0),
                                    y: (startPoint.y + (controlPoint.y - startPoint.y) * 2.0/3.0))
        let controlPoint2 = CGPoint(x: (endPoint.x + (controlPoint.x - endPoint.x) * 2.0/3.0),
                                    y: (endPoint.y + (controlPoint.y - endPoint.y) * 2.0/3.0))
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
    public static var allCorners: RectCorner  = RectCorner(rawValue: 1 << 4 - 1)

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

    convenience init(roundedRect rect: CGRect, cornerRadius: CGFloat) {
        self.init(roundedRect: rect,
                  byRoundingCorners: .allCorners,
                  cornerRadii: .init(width: cornerRadius, height: cornerRadius))
    }

    convenience init(roundedRect rect: CGRect, byRoundingCorners corners: RectCorner, cornerRadii: CGSize) {
        let path = CGMutablePath()

        // Coordinate system is flipped

        if corners.contains(.bottomLeft) {
            path.move(to: .init(x: rect.minX + cornerRadii.width,
                                y: rect.minY))
        } else {
            path.addLine(to: .init(x: rect.minX, y: rect.minY))
        }

        if corners.contains(.bottomRight) {
            path.addLine(to: .init(x: rect.maxX - cornerRadii.width, y: rect.minY))
            path.addRelativeArc(center: .init(x: rect.maxX - cornerRadii.width, y: rect.minY + cornerRadii.height),
                                radius: cornerRadii.width,
                                startAngle: -CGFloat.pi / 2,
                                delta: CGFloat.pi / 2)
        } else {
            path.addLine(to: .init(x: rect.maxX, y: rect.minY))
        }

        if corners.contains(.topRight) {
            path.addLine(to: .init(x: rect.maxX, y: rect.maxY - cornerRadii.height))
            path.addRelativeArc(center: .init(x: rect.maxX - cornerRadii.width, y: rect.maxY - cornerRadii.height),
                                radius: cornerRadii.width,
                                startAngle: 0,
                                delta: CGFloat.pi / 2)
        } else {
            path.addLine(to: .init(x: rect.maxX, y: rect.maxY))
        }

        if corners.contains(.topLeft) {
            path.addLine(to: .init(x: rect.minX + cornerRadii.width, y: rect.maxY))
            path.addRelativeArc(center: .init(x: rect.minX + cornerRadii.width, y: rect.maxY - cornerRadii.height),
                                radius: cornerRadii.width,
                                startAngle: CGFloat.pi / 2,
                                delta: CGFloat.pi / 2)
        } else {
            path.addLine(to: .init(x: rect.minX, y: rect.maxY))
        }

        if corners.contains(.bottomLeft) {
            path.addLine(to: .init(x: rect.minX, y: rect.minY + cornerRadii.height))
            path.addRelativeArc(center: .init(x: rect.minX + cornerRadii.width, y: rect.minY + cornerRadii.height),
                                radius: cornerRadii.width,
                                startAngle: CGFloat.pi,
                                delta: CGFloat.pi / 2)
        } else {
            path.addLine(to: .init(x: rect.minX, y: rect.minY))
        }

        path.closeSubpath()

        self.init(path: path)
    }
}

extension NSBezierPath {

    convenience init(path: CGPath) {
        self.init(rect: CGRect(x: 10, y: 10, width: 20, height: 20))

        path.applyWithBlock { elementPtr in
            let element = elementPtr.pointee
            let pointsPtr = element.points

            switch element.type {
            case .moveToPoint:
                self.move(to: pointsPtr.pointee)
            case .addLineToPoint:
                self.line(to: pointsPtr.pointee)
            case .addQuadCurveToPoint:
                let firstPoint = pointsPtr.pointee
                let secondPoint = pointsPtr.successor().pointee

                let currentPoint = path.currentPoint
                let x = (currentPoint.x + 2 * firstPoint.x) / 3
                let y = (currentPoint.y + 2 * firstPoint.y) / 3
                let interpolatedPoint = CGPoint(x: x, y: y)

                let endPoint = secondPoint

                self.curve(to: endPoint, controlPoint1: interpolatedPoint, controlPoint2: interpolatedPoint)
            case .addCurveToPoint:
                let firstPoint = pointsPtr.pointee
                let secondPoint = pointsPtr.successor().pointee
                let thirdPoint = pointsPtr.successor().successor().pointee

                self.curve(to: thirdPoint, controlPoint1: firstPoint, controlPoint2: secondPoint)
            case .closeSubpath:
                self.close()
            default:
                break
            }
        }
    }
}
#endif

extension CGContext {

    func draw(image: CGImage, in rect: CGRect, flipped: Bool) {
        guard flipped else {
            self.draw(image, in: rect)
            return
        }

        self.saveGState()
        self.translateBy(x: 0, y: rect.maxY)
        self.scaleBy(x: 1.0, y: -1.0)
        self.translateBy(x: 0, y: -rect.minY)
        self.draw(image, in: rect)
        self.restoreGState()
    }
}
