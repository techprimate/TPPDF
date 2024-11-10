//
//  CrossPlattformGraphics.swift
//
//  This file contains convenience types to support cross-plattform usage on iOS and macOS
//
//  Created by Philip Niedertscheider on 19.05.20.
//

#if os(iOS) || os(visionOS)
    import UIKit

    /// Cross-plattform type for `UIColor` and `NSColor`
    public typealias Color = UIColor
    /// Cross-plattform type for `UIFont` and `NSFont`
    public typealias Font = UIFont
    /// Cross-plattform type for `UIImage` and `NSImage`
    public typealias Image = UIImage
    /// Cross-plattform type for `UIEdgeInsets` and `NSEdgeInsets`
    public typealias EdgeInsets = UIEdgeInsets
    /// Cross-plattform type for `UIBezierPath` and `NSBezierPath`
    public typealias BezierPath = UIBezierPath
    /// Cross-plattform type for `CGPoint` and `NSPoint`
    public typealias Point = CGPoint
    /// Cross-plattform type for `UIRectCorner` and `RectCorner`
    public typealias RectCorner = UIRectCorner

#elseif os(macOS)

    import AppKit

    /// Cross-plattform type for `UIColor` and `NSColor`
    public typealias Color = NSColor
    /// Cross-plattform type for `UIFont` and `NSFont`
    public typealias Font = NSFont
    /// Cross-plattform type for `UIImage` and `NSImage`
    public typealias Image = NSImage
    /// Cross-plattform type for `UIEdgeInsets` and `NSEdgeInsets`
    public typealias EdgeInsets = NSEdgeInsets
    /// Cross-plattform type for `UIBezierPath` and `NSBezierPath`
    public typealias BezierPath = NSBezierPath
    /// Cross-plattform type for `CGPoint` and `NSPoint`
    public typealias Point = NSPoint

    extension NSBezierPath {
        /**
         * Extends the built-in functionality with a quad-curve operator, to match the implemenation of `UIBezierPath`
         */
        func quadCurve(to endPoint: CGPoint, controlPoint: CGPoint) {
            let startPoint = currentPoint
            let controlPoint1 = CGPoint(
                x: startPoint.x + (controlPoint.x - startPoint.x) * 2.0 / 3.0,
                y: startPoint.y + (controlPoint.y - startPoint.y) * 2.0 / 3.0
            )
            let controlPoint2 = CGPoint(
                x: endPoint.x + (controlPoint.x - endPoint.x) * 2.0 / 3.0,
                y: endPoint.y + (controlPoint.y - endPoint.y) * 2.0 / 3.0
            )
            curve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        }
    }

    public extension NSEdgeInsets {
        /// An edge insets struct whose top, left, bottom, and right fields are all set to 0.
        static var zero: NSEdgeInsets {
            NSEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }

    extension NSEdgeInsets: @retroactive Equatable {
        public static func == (lhs: NSEdgeInsets, rhs: NSEdgeInsets) -> Bool {
            lhs.top == rhs.top && lhs.left == rhs.left && lhs.bottom == rhs.bottom && lhs.right == rhs.right
        }
    }

    public struct RectCorner: OptionSet {
        public static var topLeft: RectCorner = .init(rawValue: 1 << 0)
        public static var topRight: RectCorner = .init(rawValue: 1 << 1)
        public static var bottomLeft: RectCorner = .init(rawValue: 1 << 2)
        public static var bottomRight: RectCorner = .init(rawValue: 1 << 3)
        public static var allCorners: RectCorner = .init(rawValue: 1 << 4 - 1)

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
            CGRect(x: minX + inset.left,
                   y: minY + inset.top,
                   width: width - inset.left - inset.right,
                   height: height - inset.top - inset.bottom)
        }
    }

    extension NSBezierPath {
        var cgPath: CGPath {
            let path = CGMutablePath()
            var points = [CGPoint](repeating: .zero, count: 3)
            for i in 0..<elementCount {
                let type = element(at: i, associatedPoints: &points)

                switch type {
                case .moveTo:
                    path.move(to: points[0])
                case .lineTo:
                    path.addLine(to: points[0])
                case .curveTo, .cubicCurveTo:
                    path.addCurve(to: points[2], control1: points[0], control2: points[1])
                case .quadraticCurveTo:
                    path.addQuadCurve(to: points[1], control: points[0])
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
            self.init(
                roundedRect: rect,
                byRoundingCorners: .allCorners,
                cornerRadii: .init(width: cornerRadius, height: cornerRadius)
            )
        }

        convenience init(roundedRect rect: CGRect, byRoundingCorners corners: RectCorner, cornerRadii: CGSize) { // swiftlint:disable:this function_body_length line_length
            let path = CGMutablePath()

            // Coordinate system is flipped

            if corners.contains(.bottomLeft) {
                path.move(to: .init(
                    x: rect.minX + cornerRadii.width,
                    y: rect.minY
                ))
            } else {
                path.addLine(to: .init(x: rect.minX, y: rect.minY))
            }

            if corners.contains(.bottomRight) {
                path.addLine(to: .init(x: rect.maxX - cornerRadii.width, y: rect.minY))
                path.addRelativeArc(
                    center: .init(x: rect.maxX - cornerRadii.width, y: rect.minY + cornerRadii.height),
                    radius: cornerRadii.width,
                    startAngle: -CGFloat.pi / 2,
                    delta: CGFloat.pi / 2
                )
            } else {
                path.addLine(to: .init(x: rect.maxX, y: rect.minY))
            }

            if corners.contains(.topRight) {
                path.addLine(to: .init(x: rect.maxX, y: rect.maxY - cornerRadii.height))
                path.addRelativeArc(
                    center: .init(x: rect.maxX - cornerRadii.width, y: rect.maxY - cornerRadii.height),
                    radius: cornerRadii.width,
                    startAngle: 0,
                    delta: CGFloat.pi / 2
                )
            } else {
                path.addLine(to: .init(x: rect.maxX, y: rect.maxY))
            }

            if corners.contains(.topLeft) {
                path.addLine(to: .init(x: rect.minX + cornerRadii.width, y: rect.maxY))
                path.addRelativeArc(
                    center: .init(x: rect.minX + cornerRadii.width, y: rect.maxY - cornerRadii.height),
                    radius: cornerRadii.width,
                    startAngle: CGFloat.pi / 2,
                    delta: CGFloat.pi / 2
                )
            } else {
                path.addLine(to: .init(x: rect.minX, y: rect.maxY))
            }

            if corners.contains(.bottomLeft) {
                path.addLine(to: .init(x: rect.minX, y: rect.minY + cornerRadii.height))
                path.addRelativeArc(
                    center: .init(x: rect.minX + cornerRadii.width, y: rect.minY + cornerRadii.height),
                    radius: cornerRadii.width,
                    startAngle: CGFloat.pi,
                    delta: CGFloat.pi / 2
                )
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
            draw(image, in: rect)
            return
        }

        saveGState()
        translateBy(x: 0, y: rect.maxY)
        scaleBy(x: 1.0, y: -1.0)
        translateBy(x: 0, y: -rect.minY)
        draw(image, in: rect)
        restoreGState()
    }
}
