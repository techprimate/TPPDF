//
//  PDFGraphics.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/08/2017.
//

#if os(iOS) || os(visionOS)
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
enum PDFGraphics {
    // MARK: - INTERNAL STATIC FUNCS

    // MARK: - Shape: Line

    /**
     Draws a line from the given `start` to the given `end` point into the current graphics context.

     - Parameter start: Start point of line
     - Parameter end: End point of line
     - Parameter style: Style of drawn line
     */
    static func drawLine(in context: PDFContext, start: CGPoint, end: CGPoint, style: PDFLineStyle) {
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

     - Parameter rect: Frame of rectangle
     - Parameter outline: Style of border lines
     - Parameter fill: Inner color
     */
    static func drawRect(in context: PDFContext, rect: CGRect, outline: PDFLineStyle, fill: Color = .clear) {
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

     - Parameter rect: Frame of rectangle
     - Parameter outline: Style of border lines
     - Parameter fill: Inner color
     */
    static func drawRect(in context: PDFContext, rect: CGRect, outline: PDFLineStyle, pattern: FillPattern) {
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
     * Draws the `path` in the `context` using the given `outline` style for the stroke and `fillColor` for filling the shape
     *
     * - Parameters:
     *     - path: Instance of ``BezierPath`` to draw
     *     - context: PDF graphics context
     *     - outline: Style of the stroke outline
     *     - fillColor: ``Color`` used to fill the shape
     */
    static func drawPath(path: BezierPath, in context: PDFContext, outline: PDFLineStyle, fillColor: Color) {
        prepareForDrawingPath(path: path.cgPath, in: context, strokeStyle: outline)
        context.setFillColor(fillColor.cgColor)
        context.drawPath(using: .fillStroke)
    }

    /**
     * Helper method to prepare the graphics context `context` to draw the given `path`
     */
    static func prepareForDrawingPath(path: CGPath, in context: PDFContext, strokeStyle: PDFLineStyle) {
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

     - Parameter style: Style of line
     - Parameter path: Reference to the path, which will be manipulated.

     - Returns: Array with dash values
     */
    static func createDashes(style: PDFLineStyle) -> (lengths: [CGFloat], cap: CGLineCap)? {
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

     - Parameter image: Image to resize and compress
     - Parameter frame: Frame in which the new image will fit
     - Parameter shouldResize: Flag if image should be resized to frame before drawing
     - Parameter shouldCompress: Flag if image should be compressed to quality before drawing
     - Parameter quality: Value between 0.0 and 1.0, where 1.0 is maximum quality
     - Parameter roundCorners: Indicates which corners should be rounded, defaults to be empty
     - Parameter cornerRadii: Radius of corners which are rounded based on `roundCorners`, if `nil` it will create a fully round image

     - Returns: Resized, compressed and rounded copy of `image`
     */
    static func resizeAndCompressImage(image: Image, frame: CGRect,
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

     - Parameter image: Image to resize
     - Parameter frame: Frame in which the new image will fit
     - Parameter quality: Value between 0.0 and 1.0, where 1.0 is maximum quality, used for size calculations

     - Returns: Resized version of `image`
     */
    static func resize(image: Image, frame: CGRect, quality: CGFloat) -> Image {
        let factor: CGFloat = min(3 * quality, 1)
        let resizeFactor = factor.isZero ? 0.2 : factor

        // If there is a floating point error, e.g. 24.000000000000004, then UIKit will use the next higher integer value, but AppKit does not
        let size = CGSize(width: floor(frame.width * resizeFactor),
                          height: floor(frame.height * resizeFactor))

        #if os(iOS) || os(visionOS)
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

     - Parameter image: Image to compress
     - Parameter quality: Value between 0.0 and 1.0, where 1.0 is maximum quality/least compression

     - Returns: Compressed image
     */
    static func compress(image: Image, quality: CGFloat) -> Image {
        #if os(iOS) || os(visionOS)
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

     - Parameter image: Image to edit
     - Parameter size: Size of final image, used to calculate correct radii limits
     - Parameter cornerRadius: Optional value used as radius, if null half of the minimum of the size width or height is used,
     resulting in a round image

     - Returns: Manipulated image
     */
    static func round(image: Image, frameSize: CGSize, corners: RectCorner, cornerRadius: CGFloat?) -> Image {
        let size = image.size

        var cornerRadii = CGSize.zero
        if var radius = cornerRadius {
            radius *= (frameSize.width > frameSize.height ? size.width / frameSize.width : size.height / frameSize.height)
            cornerRadii = CGSize(width: radius, height: radius)
        } else {
            let radius = size.width < size.height ? frameSize.width / 2 : frameSize.height / 2
            cornerRadii = CGSize(width: radius, height: radius)
        }

        let clipPath = BezierPath(roundedRect: CGRect(origin: .zero, size: size), byRoundingCorners: corners, cornerRadii: cornerRadii)

        #if os(iOS) || os(visionOS)
            UIGraphicsBeginImageContext(size)
        #elseif os(macOS)
            let finalImage = NSImage(size: size)
            finalImage.lockFocus()
        #endif

        clipPath.addClip()
        image.draw(in: CGRect(origin: .zero, size: size))

        #if os(iOS) || os(visionOS)
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
     * Constants for filling, mostly used for debugging elements
     */
    enum FillPattern {
        case dotted(foreColor: Color, backColor: Color)
        func setFill(in context: PDFContext) {
            switch self {
            case let .dotted(foreColor, backColor):
                let size = CGSize(width: 5, height: 5)

                #if os(iOS) || os(visionOS)
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

                #if os(iOS) || os(visionOS)
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
