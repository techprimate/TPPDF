//
//  PDFGraphics.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/08/2017.
//

/**
 Contains a collection methods to render the following shapes:

 - Line
 - Rectangles

 Also contains a collection of graphic utilities:

 - Image resizing and compression
 */
class PDFGraphics {

    // MARK: - INTERNAL STATIC FUNCS

    // MARK: - Shape: Line

    /**
     Draws a line from the given `start` to the given `end` point into the current graphics context.

     - parameter start: Start point of line
     - parameter end: End point of line
     - parameter style: Style of drawn line
     */
    static func drawLine(start: CGPoint, end: CGPoint, style: PDFLineStyle) {
        if let path = createLinePath(start: start, end: end, style: style) {
            style.color.setStroke()

            path.stroke()
        }
    }

    /**
     Creates a path containing a line from the given `start` to the given `end` point.

     - parameter start: Start point of line
     - parameter end: End point of line
     - parameter style: Style of drawn line

     - returns: Bezier path of line, `nil` if line type in `style` was `PDFLineType.none`
     */
    static func createLinePath(start: CGPoint, end: CGPoint, style: PDFLineStyle) -> UIBezierPath? {
        if style.type == .none {
            return nil
        }

        var path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)

        let dashes = createDashes(style: style, path: &path)
        path.setLineDash(dashes, count: dashes.count, phase: 0.0)
        path.lineWidth = CGFloat(style.width)

        return path
    }

    // MARK: - Shape: Rectangle

    /**
     Draws a rectangle into the given `frame`.

     - parameter rect: Frame of rectangle
     - parameter outline: Style of border lines
     - parameter fill: Inner color
     */
    static func drawRect(rect: CGRect, outline: PDFLineStyle, fill: UIColor = .clear) {
        let path = createRectPath(rect: rect, outline: outline)

        outline.color.setStroke()
        fill.setFill()

        path.fill()
        path.stroke()
    }

    /**
     Draws a rectangle into the given `frame`.

     - parameter rect: Frame of rectangle
     - parameter outline: Style of border lines
     - parameter fill: Inner color
     */
    static func drawRect(rect: CGRect, outline: PDFLineStyle, pattern: FillPattern) {
        let path = createRectPath(rect: rect, outline: outline)

        outline.color.setStroke()
        pattern.setFill()

        path.fill()
        path.stroke()
    }

    /**
     Creates a rectangular bezier path from the given `frame`.

     - parameter rect: Frame of rectangle
     - parameter outline: Style of border lines
     */
    static func createRectPath(rect: CGRect, outline: PDFLineStyle) -> UIBezierPath {
        var path = UIBezierPath(rect: rect)
        if let radius = outline.radius {
            path = UIBezierPath.init(roundedRect: rect, cornerRadius: radius)
        }

        let dashes = createDashes(style: outline, path: &path)
        path.setLineDash(dashes, count: dashes.count, phase: 0.0)
        path.lineWidth = CGFloat(outline.width)
        return path
    }

    // MARK: - Shape Utility

    /**
     Creates an array of dash values. Used to define dashes of a `UIBezierPath`.
     Array is empty if line type is not a dashed or dotted.
     This also sets the `UIBezierPath.lineCapStyle`.

     - parameter style: Style of line
     - parameter path: Reference to the path, which will be manipulated.

     - returns: Array with dash values
     */
    static func createDashes(style: PDFLineStyle, path: inout UIBezierPath) -> [CGFloat] {
        var dashes: [CGFloat] = []

        switch style.type {
        case .dashed:
            dashes = [style.width * 3, style.width * 3]
            path.lineCapStyle = .butt
        case .dotted:
            dashes = [0, style.width * 2]
            path.lineCapStyle = .round
        default:
            break
        }

        return dashes
    }

    // MARK: - Image Manipulation

    /**
     Draws a scaled version of the given `image` into the given `frame`.

     - parameter image: Image to resize and compress
     - parameter frame: Frame in which the new image will fit
     - parameter quality: Value between 0.0 and 1.0, where 1.0 is maximum quality

     - returns: Resized and compressed version of `image`
     */
    static func resizeAndCompressImage(image: UIImage, frame: CGRect, shouldResize: Bool, shouldCompress: Bool, quality: CGFloat) -> UIImage {
        var finalImage = image

        if shouldResize {
            finalImage = resize(image: finalImage, frame: frame, quality: quality)
        }
        if shouldCompress {
            finalImage = compress(image: finalImage, quality: quality)
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
    static func resize(image: UIImage, frame: CGRect, quality: CGFloat) -> UIImage {
        let factor: CGFloat = min(3 * quality, 1)
        let resizeFactor = factor.isZero ? 0.2 : factor

        let size = CGSize(width: frame.width * resizeFactor,
                          height: frame.height * resizeFactor)

        UIGraphicsBeginImageContext(size)
        image.draw(in: CGRect(origin: .zero, size: size))
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return finalImage ?? image
    }

    /**
     Performs JPEG compression on the given image.
     If the given image can not be compressed, it will silently return the original image.

     - parameter image: Image to compress
     - parameter quality: Value between 0.0 and 1.0, where 1.0 is maximum quality/least compression
     */
    static func compress(image: UIImage, quality: CGFloat) -> UIImage {
        guard let data = image.jpegData(compressionQuality: quality) else {
            return image
        }
        guard let compressed = UIImage(data: data) else {
            return image
        }
        return compressed
    }

    /**
     Constants for filling, mostly used for debugging elements
     */
    enum FillPattern {

        case dotted(foreColor: UIColor, backColor: UIColor)

        func setFill() {
            switch self {
            case .dotted(let foreColor, let backColor):
                UIGraphicsBeginImageContext(CGSize(width: 5, height: 5))
                UIColor.clear.setStroke()
                backColor.setFill()

                var path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 5, height: 5))
                path.fill()

                foreColor.setFill()

                path = UIBezierPath(ovalIn: CGRect(x: 2.5, y: 2.5, width: 2.5, height: 2.5))
                path.fill()

                let image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                UIColor(patternImage: image!).setFill()
            }
        }

    }

}
