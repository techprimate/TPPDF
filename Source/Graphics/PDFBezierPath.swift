//
//  PDFBezierPath.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 01.06.19.
//

import Foundation
import UIKit

public class PDFBezierPath {

    enum ElementType {
        case move(point: PDFBezierPathVertex)
        case line(point: PDFBezierPathVertex)
        case curve(endPoint: PDFBezierPathVertex, controlPoint1: PDFBezierPathVertex, controlPoint2: PDFBezierPathVertex)
        case quadCurve(endPoint: PDFBezierPathVertex, controlPoint: PDFBezierPathVertex)
        case arc(center: PDFBezierPathVertex, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool)
        case close
    }

    private var refFrame: CGRect
    private var elements: [ElementType] = []

    public init(ref: CGRect) {
        self.refFrame = ref
    }

    public func move(to point: PDFBezierPathVertex) {
        elements.append(.move(point: point))
    }

    public func addLine(to point: PDFBezierPathVertex) {
        elements.append(.line(point: point))
    }

    public func addCurve(to endPoint: PDFBezierPathVertex, controlPoint1: PDFBezierPathVertex, controlPoint2: PDFBezierPathVertex) {
        elements.append(.curve(endPoint: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2))
    }

    public func addQuadCurve(to endPoint: PDFBezierPathVertex, controlPoint: PDFBezierPathVertex) {
        elements.append(.quadCurve(endPoint: endPoint, controlPoint: controlPoint))
    }

    public func addArc(withCenter center: PDFBezierPathVertex, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool) {
        elements.append(.arc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise))
    }

    public func close() {
        elements.append(.close)
    }

    public func bezierPath(in frame: CGRect) -> UIBezierPath {
        let bezierPath = UIBezierPath()
        for element in elements {
            switch element {
            case .move(let point):
                bezierPath.move(to: calculate(point: point, in: frame))
            case .line(let point):
                bezierPath.addLine(to: calculate(point: point, in: frame))
            case .curve(let endPoint, let controlPoint1, let controlPoint2):
                bezierPath.addCurve(to: calculate(point: endPoint, in: frame),
                                    controlPoint1: calculate(point: controlPoint1, in: frame),
                                    controlPoint2: calculate(point: controlPoint2, in: frame))
            case .quadCurve(let endPoint, let controlPoint):
                bezierPath.addQuadCurve(to: calculate(point: endPoint, in: frame),
                                        controlPoint: calculate(point: controlPoint, in: frame))
            case .arc(let center, let radius, let startAngle, let endAngle, let clockwise):
                bezierPath.addArc(withCenter: calculate(point: center, in: frame),
                                  radius: radius,
                                  startAngle: startAngle,
                                  endAngle: endAngle,
                                  clockwise: clockwise)
            case .close:
                bezierPath.close()
            }
        }
        return bezierPath
    }

    private func calculate(point: PDFBezierPathVertex, in frame: CGRect) -> CGPoint {
        let diffX: CGFloat = {
            switch point.anchor {
            case .topLeft, .middleLeft, .bottomLeft:
                return frame.minX - refFrame.minX
            case .topCenter, .middleCenter, .bottomCenter:
                return frame.midX - refFrame.midX
            case .topRight, .middleRight, .bottomRight:
                return frame.maxX - refFrame.maxX
            }
        }()
        let diffY: CGFloat = {
            switch point.anchor {
            case .topLeft, .topCenter, .topRight:
                return frame.minY - refFrame.minY
            case .middleLeft, .middleCenter, .middleRight:
                return frame.midY - refFrame.midY
            case .bottomLeft, .bottomCenter, .bottomRight:
                return frame.maxY - refFrame.maxY
            }
        }()
        let diff = CGVector(dx: diffX, dy: diffY)
        return point.position + diff
    }
}
