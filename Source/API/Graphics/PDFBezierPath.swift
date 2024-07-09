//
//  PDFBezierPath.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 01.06.19.
//

#if os(iOS) || os(visionOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

/**
 * Structure to create a bezier path, similar to  ``UIKit.UIBezierPath``
 *
 * A bezier path consists of a set of elements relative to a reference frame, to produce a path.
 * When using the ``close`` as the last element, the path will be considered as a shape instead.
 *
 * **Example for a diamond shape:**
 *
 *     let size = CGSize(width: 100, height: 100)
 *     let path = PDFBezierPath(ref: CGRect(origin: .zero, size: size))
 *     path.move(to: PDFBezierPathVertex(
 *          position: CGPoint(x: size.width / 2, y: 0),
 *         anchor: .topCenter
 *     ))
 *     path.addLine(to: PDFBezierPathVertex(
 *         position: CGPoint(x: size.width, y: size.height / 2),
 *         anchor: .middleRight
 *     ))
 *     path.addLine(to: PDFBezierPathVertex(
 *         position: CGPoint(x: size.width / 2, y: size.height),
 *         anchor: .bottomCenter
 *     ))
 *     path.addLine(to: PDFBezierPathVertex(
 *         position: CGPoint(x: 0, y: size.height / 2),
 *         anchor: .middleLeft
 *     ))
 *     path.close()
 *
 * The ``PDFBezierPathVertex/anchor-swift.property`` is used to handle differences between the ``PDFBezierPath/refFrame``
 */
public class PDFBezierPath: CustomStringConvertible {
    /// Elements of the path, which are processed in order
    enum ElementType {
        /// See ``PDFBezierPath/move(to:)`` for details
        case move(point: PDFBezierPathVertex)

        /// See ``PDFBezierPath/addLine(to:)`` for details
        case line(point: PDFBezierPathVertex)

        /// See ``PDFBezierPath/addCurve(to:controlPoint1:controlPoint2:)`` for details
        case curve(endPoint: PDFBezierPathVertex, controlPoint1: PDFBezierPathVertex, controlPoint2: PDFBezierPathVertex)

        /// See ``PDFBezierPath/addQuadCurve(to:controlPoint:)`` for details
        case quadCurve(endPoint: PDFBezierPathVertex, controlPoint: PDFBezierPathVertex)

        /// See ``PDFBezierPath/addArc(withCenter:radius:startAngle:endAngle:clockwise:)`` for details
        case arc(center: PDFBezierPathVertex, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool)

        /// See ``PDFBezierPath/close()`` for details
        case close
    }

    /// Frame used as reference for vertext anchors
    var refFrame: CGRect

    /// Elements in this path
    var elements: [ElementType] = []

    /**
     * Creates a new bezier path with the given reference frame.
     *
     * When creating a new path, the path cursor is set to the default origin at `(0,0)`.
     *
     * - Parameter ref: Reference frame
     */
    public init(ref: CGRect) {
        self.refFrame = ref
    }

    /**
     * Moves the path’s current point to the specified location.
     *
     * This method implicitly ends the current subpath (if any) and sets the current point to the value in the `point` parameter.
     * When ending the previous subpath, this method does not actually close the subpath.
     * Therefore, the first and last points of the previous subpath are not connected to each other.
     *
     * For many path operations, you must call this method before issuing any commands that cause a line or curve segment to be drawn.
     *
     * - Parameter point: A point in the current coordinate system.
     */
    public func move(to point: PDFBezierPathVertex) {
        elements.append(.move(point: point))
    }

    /**
     * Appends a straight line to the path.
     *
     * This method creates a straight line segment starting at the current point and ending at the point specified by the `point` parameter.
     * After adding the line segment, this method updates the current point to the value in `point`.
     * You must set the path’s current point (using the ``PDFBezierPath/move(to:)`` method or through the previous creation of a line
     * or curve segment) before you call this method.
     * If the path is empty, this method does nothing.
     *
     * - Parameter point: The destination point of the line segment, specified in the current coordinate system.
     */
    public func addLine(to point: PDFBezierPathVertex) {
        elements.append(.line(point: point))
    }

    /**
     * Appends a cubic Bézier curve to the path.
     *
     * This method appends a cubic Bézier curve from the current point to the end point specified by the `endPoint` parameter.
     * The two control points define the curvature of the segment. Figure 1 shows an approximation of a cubic Bézier curve given a
     * set of initial points.
     * The exact curvature of the segment involves a complex mathematical relationship between all of the points and is well documented online.
     *
     * You must set the path’s current point (using the ``PDFBezierPath/move(to:)`` method or through the previous creation
     * of a line or curve segment) before you call this method. If the path is empty, this method does nothing.
     * After adding the curve segment, this method updates the current point to the value in `point`.
     *
     * - Parameters:
     *      - endPoint: The end point of the curve.
     *      - controlPoint1: The first control point to use when computing the curve.
     *      - controlPoint2: The second control point to use when computing the curve.

     */
    public func addCurve(to endPoint: PDFBezierPathVertex, controlPoint1: PDFBezierPathVertex, controlPoint2: PDFBezierPathVertex) {
        elements.append(.curve(endPoint: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2))
    }

    /**
     * Appends a quadratic Bézier curve to the path.
     *
     * This method appends a quadratic Bézier curve from the current point to the end point specified by the endPoint parameter.
     * The relationships between the current point, control point, and end point are what defines the actual curve.
     * The exact curvature of the segment involves a complex mathematical relationship between the points and is well documented online.
     *
     * You must set the path’s current point (using the ``PDFBezierPath/move(to:)`` method or through the previous creation of a line
     * or curve segment) before you call this method. If the path is empty, this method does nothing.
     * After adding the curve segment, this method updates the current point to the value in point.
     *
     * See ``UIBezierPath/addQuadCurve`` for more details.
     *
     * - Parameter endPoint: The end point of the curve.
     * - Parameter controlPoint: The control point of the curve.
     */
    public func addQuadCurve(to endPoint: PDFBezierPathVertex, controlPoint: PDFBezierPathVertex) {
        elements.append(.quadCurve(endPoint: endPoint, controlPoint: controlPoint))
    }

    /**
     * Appends an arc to the path.
     *
     * This method adds the specified arc beginning at the current point.
     * The created arc lies on the perimeter of the specified circle.
     * When drawn in the default coordinate system, the start of the circle is at the right end.
     * For example, specifying a start angle of 0 radians, an end angle of π radians, and setting the `clockwise` parameter to `true` draws
     * the bottom half of the circle.
     * However, specifying the same start and end angles but setting the `clockwise` parameter set to false draws the top half of the circle.
     * After calling this method, the current point is set to the point on the arc at the end angle of the circle.
     *
     * See ``UIBezierPath/addArc`` for more details.
     *
     * - Parameters:
     *      - center: Specifies the center point of the circle (in the current coordinate system) used to define the arc.
     *      - radius: Specifies the radius of the circle used to define the arc.
     *      - startAngle: Specifies the starting angle of the arc (measured in radians).
     *      - endAngle: Specifies the end angle of the arc (measured in radians).
     *      - clockwise: The direction in which to draw the arc.
     */
    public func addArc(withCenter center: PDFBezierPathVertex, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool) {
        elements.append(.arc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise))
    }

    /// Closes the most recent subpath.
    public func close() {
        elements.append(.close)
    }

    /**
     * Converts this path into an `UIBezierPath` / `NSBezierPath`
     *
     * As an instance of `PDFBezierPath` uses a reference frame for anchoring coordinates, the given parameter `frame` is used as the target frame,
     * for scaling in relative values using each element's anchor
     *
     * - Parameter frame: Target frame for scaling this path
     *
     * - Returns: `UIBezierPath` for iOS or `NSBezierPath` for macOS
     */
    public func bezierPath(in frame: CGRect) -> BezierPath { // swiftlint:disable:this function_body_length
        let bezierPath = BezierPath()
        for element in elements {
            switch element {
            case let .move(point):
                bezierPath.move(to: calculate(point: point, in: frame))
            case let .line(point):
                #if os(iOS) || os(visionOS)
                    bezierPath.addLine(to: calculate(point: point, in: frame))
                #else
                    bezierPath.line(to: calculate(point: point, in: frame))
                #endif
            case let .curve(endPoint, controlPoint1, controlPoint2):
                #if os(iOS) || os(visionOS)
                    bezierPath.addCurve(
                        to: calculate(point: endPoint, in: frame),
                        controlPoint1: calculate(point: controlPoint1, in: frame),
                        controlPoint2: calculate(point: controlPoint2, in: frame)
                    )
                #else
                    bezierPath.curve(
                        to: calculate(point: endPoint, in: frame),
                        controlPoint1: calculate(point: controlPoint1, in: frame),
                        controlPoint2: calculate(point: controlPoint2, in: frame)
                    )
                #endif
            case let .quadCurve(endPoint, controlPoint):
                #if os(iOS) || os(visionOS)
                    bezierPath.addQuadCurve(
                        to: calculate(point: endPoint, in: frame),
                        controlPoint: calculate(point: controlPoint, in: frame)
                    )
                #else
                    bezierPath.quadCurve(
                        to: calculate(point: endPoint, in: frame),
                        controlPoint: calculate(point: controlPoint, in: frame)
                    )
                #endif
            case let .arc(center, radius, startAngle, endAngle, clockwise):
                #if os(iOS) || os(visionOS)
                    bezierPath.addArc(
                        withCenter: calculate(point: center, in: frame),
                        radius: radius,
                        startAngle: startAngle,
                        endAngle: endAngle,
                        clockwise: clockwise
                    )
                #else
                    bezierPath.appendArc(
                        withCenter: calculate(point: center, in: frame),
                        radius: radius,
                        startAngle: startAngle,
                        endAngle: endAngle,
                        clockwise: clockwise
                    )
                #endif
            case .close:
                bezierPath.close()
            }
        }
        return bezierPath
    }

    /**
     * Helper function to calculate the relative position of a vertext to a target frame
     *
     * See ``PDFBezierPathVertex/Anchor-swift.enum`` for details for anchor behaviour.
     *
     * - Parameter point: Vertex in this bezier path
     * - Parameter frame: Target frame used to calculate relative coordinates
     *
     * - Returns: Scaled coordinates relative to given `frame`
     */
    private func calculate(point: PDFBezierPathVertex, in frame: CGRect) -> CGPoint {
        let diff = CGVector(
            dx: calculateDiffX(point: point, in: frame),
            dy: calculateDiffY(point: point, in: frame)
        )
        return point.position + diff
    }

    /**
     * Helper function to calculate the relative horizontal position of a vertext to a target frame
     *
     * The horizontal anchors are separated into `left`, `center`, and `right`.
     * See ``PDFBezierPathVertex/Anchor-swift.enum`` for details for anchor behaviour.
     *
     * - Parameter point: Vertex in this bezier path
     * - Parameter frame: Target frame used to calculate relative coordinates
     *
     * - Returns: Scaled horizontal coordinates relative to given `frame`
     */
    private func calculateDiffX(point: PDFBezierPathVertex, in frame: CGRect) -> CGFloat {
        switch point.anchor {
        case .topLeft, .middleLeft, .bottomLeft:
            return frame.minX - refFrame.minX
        case .topCenter, .middleCenter, .bottomCenter:
            return frame.midX - refFrame.midX
        case .topRight, .middleRight, .bottomRight:
            return frame.maxX - refFrame.maxX
        }
    }

    /**
     * Helper function to calculate the relative vertical position of a vertext to a target frame
     *
     * The horizontal anchors are separated into `top`, `middle`, and `bottom`.
     * See ``PDFBezierPathVertex/Anchor-swift.enum`` for details for anchor behaviour.
     *
     * - Parameter point: Vertex in this bezier path
     * - Parameter frame: Target frame used to calculate relative coordinates
     *
     * - Returns: Scaled vertical coordinates relative to given `frame`
     */
    private func calculateDiffY(point: PDFBezierPathVertex, in frame: CGRect) -> CGFloat {
        switch point.anchor {
        case .topLeft, .topCenter, .topRight:
            return frame.minY - refFrame.minY
        case .middleLeft, .middleCenter, .middleRight:
            return frame.midY - refFrame.midY
        case .bottomLeft, .bottomCenter, .bottomRight:
            return frame.maxY - refFrame.maxY
        }
    }
}
