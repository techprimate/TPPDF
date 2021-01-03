//
//  PDFGraphics.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/08/2017.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/**
 Contains a collection methods to render the following shapes:

 - Line
 - Rectangles

 Also contains a collection of graphic utilities:

 - Image resizing and compression
 */
internal enum PDFGraphics {

    // MARK: - INTERNAL STATIC FUNCS

    // MARK: - Shape: Line

    /**
     Draws a line from the given `start` to the given `end` point into the current graphics context.

     - parameter start: Start point of line
     - parameter end: End point of line
     - parameter style: Style of drawn line
     */
    internal static func drawLine(in context: PDFContext, start: CGPoint, end: CGPoint, style: PDFLineStyle) {
        guard style.type != .none else {
            return
        }

        let path = CGMutablePath()
        path.move(to: start)
        path.addLine(to: end)

        prepareForDrawingPath(path: path, in: context, strokeStyle: style)

        context.drawPath(using: .stroke)
    }

    // MARK: - Shape: Rectangle

    /**
     Draws a rectangle into the given `frame`.

     - parameter rect: Frame of rectangle
     - parameter outline: Style of border lines
     - parameter fill: Inner color
     */
    internal static func drawRect(in context: PDFContext, rect: CGRect, outline: PDFLineStyle, fill: Color = .clear) {
        var path = BezierPath(rect: rect)
        if let radius = outline.radius {
            path = BezierPath(roundedRect: rect, cornerRadius: radius)
        }
        prepareForDrawingPath(path: path.cgPath, in: context, strokeStyle: outline)
        context.setFillColor(fill.cgColor)
        context.drawPath(using: .fillStroke)
    }

    /**
     Draws a rectangle into the given `frame`.

     - parameter rect: Frame of rectangle
     - parameter outline: Style of border lines
     - parameter fill: Inner color
     */
    internal static func drawRect(in context: PDFContext, rect: CGRect, outline: PDFLineStyle, pattern: FillPattern) {
        var path = BezierPath(rect: rect)
        if let radius = outline.radius {
            path = BezierPath(roundedRect: rect, cornerRadius: radius)
        }
        prepareForDrawingPath(path: path.cgPath, in: context, strokeStyle: outline)
        pattern.setFill(in: context)
        context.drawPath(using: .fillStroke)
    }

    // MARK: - Shape Utility

    /**
     TODO: Documentation
     */
    internal static func drawPath(path: BezierPath, in context: PDFContext, outline: PDFLineStyle, fillColor: Color) {
        prepareForDrawingPath(path: path.cgPath, in: context, strokeStyle: outline)
        context.setFillColor(fillColor.cgColor)
        context.drawPath(using: .fillStroke)
    }

    /**
     TODO: Documentation
     */
    internal static func prepareForDrawingPath(path: CGPath, in context: PDFContext, strokeStyle: PDFLineStyle) {
        context.beginPath()
        context.addPath(path)

        if let dashes = createDashes(style: strokeStyle) {
            context.setLineDash(phase: 0, lengths: dashes.lengths)
            context.setLineCap(dashes.cap)
        }
        context.setLineWidth(strokeStyle.width)
        context.setStrokeColor(strokeStyle.color.cgColor)
    }

    /**
     Creates an array of dash values. Used to define dashes of a `BezierPath`.
     Array is empty if line type is not a dashed or dotted.
     This also sets the `BezierPath.lineCapStyle`.

     - parameter style: Style of line
     - parameter path: Reference to the path, which will be manipulated.

     - returns: Array with dash values
     */
    internal static func createDashes(style: PDFLineStyle) -> (lengths: [CGFloat], cap: CGLineCap)? {
        switch style.type {
        case .dashed:
            return ([style.width * 3, style.width * 3], .butt)
        case .dotted:
            return ([0, style.width * 2], .round)
        default:
            return nil
        }
    }

    // MARK: - Image Manipulation

    /**
     Creates a scaled version of the given `image` by the given `frame` and add optional corner clipping.

     - parameter image: Image to resize and compress
     - parameter frame: Frame in which the new image will fit
     - parameter shouldResize: Flag if image should be resized to frame before drawing
     - parameter shouldCompress: Flag if image should be compressed to quality before drawing
     - parameter quality: Value between 0.0 and 1.0, where 1.0 is maximum quality
     - parameter roundCorners: Indicates which corners should be rounded, defaults to be empty
     - parameter cornerRadii: Radius of corners which are rounded based on `roundCorners`, if `nil` it will create a fully round image

     - returns: Resized, compressed and rounded copy of `image`
     */
    internal static func resizeAndCompressImage(image: Image, frame: CGRect,
                                                shouldResize: Bool, shouldCompress: Bool,
                                                quality: CGFloat,
                                                roundCorners: RectCorner = [], cornerRadius: CGFloat? = nil) -> Image {
        var finalImage = image

        if shouldResize {
            finalImage = resize(image: finalImage, frame: frame, quality: quality)
        }
        if shouldCompress {
            finalImage = compress(image: finalImage, quality: quality)
        }
        if !roundCorners.isEmpty {
            finalImage = round(image: finalImage, frameSize: frame.size, corners: roundCorners, cornerRadius: cornerRadius)
        }

        return finalImage
    }

    /**
     Draws a scaled version of the given `image` into the given `frame`.

     - parameter image: Image to resize
     - parameter frame: Frame in which the new image will fit
     - parameter quality: Value between 0.0 and 1.0, where 1.0 is maximum quality, used for size calculations

     - returns: Resized version of `image`
     */
    internal static func resize(image: Image, frame: CGRect, quality: CGFloat) -> Image {
        let factor: CGFloat = min(3 * quality, 1)
        let resizeFactor = factor.isZero ? 0.2 : factor

        // If there is a floating point error, e.g. 24.000000000000004, then UIKit will use the next higher integer value, but AppKit does not
        let size = CGSize(width: floor(frame.width * resizeFactor),
                          height: floor(frame.height * resizeFactor))

        #if os(iOS)
        UIGraphicsBeginImageContext(size)
        image.draw(in: CGRect(origin: .zero, size: size))
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return finalImage ?? image
        #elseif os(macOS)
        let finalImage = NSImage(size: size)
        finalImage.lockFocus()
        let context = NSGraphicsContext.current!
        context.imageInterpolation = .high
        image.draw(in: CGRect(origin: .zero, size: size))
        finalImage.unlockFocus()
        return finalImage
        #endif
    }

    /**
     Performs JPEG compression on the given image.
     If the given image can not be compressed, it will silently return the original image.

     - parameter image: Image to compress
     - parameter quality: Value between 0.0 and 1.0, where 1.0 is maximum quality/least compression

     - returns: Compressed image
     */
    internal static func compress(image: Image, quality: CGFloat) -> Image {
        #if os(iOS)
        guard let data = image.jpegData(compressionQuality: quality) else {
            return image
        }
        #elseif os(macOS)
        guard let imageData = image.tiffRepresentation,
            let bitmapData = NSBitmapImageRep(data: imageData),
            let data = bitmapData.representation(using: .jpeg, properties: [:]) else {
                return image
        }
        #endif
        guard let compressed = Image(data: data) else {
            return image
        }
        return compressed
    }

    /**
     Clips an image to add round corners

     - parameter image: Image to edit
     - parameter size: Size of final image, used to calculate correct radii limits
     - parameter cornerRadius: Optional value used as radius, if null half of the minimum of the size width or height is used,
     resulting in a round image

     - returns: Manipulated image
     */
    internal static func round(image: Image, frameSize: CGSize, corners: RectCorner, cornerRadius: CGFloat?) -> Image {
        let size = image.size

        var cornerRadii = CGSize.zero
        if var radius = cornerRadius {
            radius = radius * (frameSize.width > frameSize.height ? size.width / frameSize.width : size.height / frameSize.height)
            cornerRadii = CGSize(width: radius, height: radius)
        } else {
            let radius = size.width < size.height ? frameSize.width / 2 : frameSize.height / 2
            cornerRadii = CGSize(width: radius, height: radius)
        }

        let clipPath = BezierPath(roundedRect: CGRect(origin: .zero, size: size), byRoundingCorners: corners, cornerRadii: cornerRadii)

        #if os(iOS)
        UIGraphicsBeginImageContext(size)
        #elseif os(macOS)
        let finalImage = NSImage(size: size)
        finalImage.lockFocus()
        #endif

        clipPath.addClip()
        image.draw(in: CGRect(origin: .zero, size: size))

        #if os(iOS)
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return finalImage ?? image
        #elseif os(macOS)
        finalImage.unlockFocus()
        guard let data = finalImage.tiffRepresentation,
            let imageRep = NSBitmapImageRep(data: data),
            let pngData = imageRep.representation(using: .png, properties: [:]) else {
                return image
        }
        return NSImage(data: pngData) ?? image
        #endif
    }

    /**
     Constants for filling, mostly used for debugging elements
     */
    internal enum FillPattern {

        /**
         TODO: Documentation
         */
        case dotted(foreColor: Color, backColor: Color)

        /**
         TODO: Documentation
         */
        internal func setFill(in context: PDFContext) {
            switch self {
            case .dotted(let foreColor, let backColor):
                let size = CGSize(width: 5, height: 5)

                #if os(iOS)
                UIGraphicsBeginImageContext(size)
                #elseif os(macOS)
                let image = NSImage(size: size)
                image.lockFocus()
                #endif

                Color.clear.setStroke()
                backColor.setFill()
                var path = BezierPath(rect: CGRect(x: 0, y: 0, width: 5, height: 5))
                path.fill()

                foreColor.setFill()
                path = BezierPath(ovalIn: CGRect(x: 2.5, y: 2.5, width: 2.5, height: 2.5))
                path.fill()

                #if os(iOS)
                let image = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
                #elseif os(macOS)
                image.unlockFocus()
                #endif

                context.setFillColor(Color(patternImage: image).cgColor)
            }
        }
    }
}
