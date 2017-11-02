//
//  PDFGraphics.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/08/2017.
//
//

class PDFGraphics {

    // MARK: - Lines

    static func drawLine(start: CGPoint, end: CGPoint, style: PDFLineStyle) {
        if let path = createLinePath(start: start, end: end, style: style) {
            style.color.setStroke()

            path.stroke()
        }
    }

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

    static func drawRect(rect: CGRect, outline: PDFLineStyle, fill: UIColor = .clear) {
        let path = createRectPath(rect: rect, outline: outline)

        outline.color.setStroke()
        fill.setFill()

        path.fill()
        path.stroke()
    }

    static func createRectPath(rect: CGRect, outline: PDFLineStyle) -> UIBezierPath {
        var path = UIBezierPath(rect: rect)

        let dashes = createDashes(style: outline, path: &path)
        path.setLineDash(dashes, count: dashes.count, phase: 0.0)
        path.lineWidth = CGFloat(outline.width)

        return path
    }

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

    // MARK: - Image

    static func resizeAndCompressImage(image: UIImage, frame: CGRect, quality: CGFloat) -> UIImage {
        // resize
        let resizeFactor = (3 * quality > 1) ? 1 : 3 * quality
        let resizeImageSize = CGSize(width: frame.size.width * resizeFactor, height: frame.size.height * resizeFactor)
        
        UIGraphicsBeginImageContext(resizeImageSize)
        image.draw(in: CGRect(x: 0, y: 0, width: resizeImageSize.width, height: resizeImageSize.height))
        var compressedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // compression
        if let image = compressedImage, let jpegData = UIImageJPEGRepresentation(image, quality) {
            compressedImage = UIImage(data: jpegData)
        }
        return compressedImage ?? image
    }
}
