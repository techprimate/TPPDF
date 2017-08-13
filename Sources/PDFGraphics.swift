//
//  PDFGraphics.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/08/2017.
//
//

class PDFGraphics {
    
    static func drawLine(start: CGPoint, end: CGPoint, style: PDFLineStyle) {
        if style.type == .none {
            return
        }
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        
        path.lineWidth = CGFloat(style.width)
        
        var dashes: [CGFloat] = []
        
        switch style.type {
        case .dashed:
            dashes = [path.lineWidth * 3, path.lineWidth * 3]
            path.lineCapStyle = .butt
            break
        case .dotted:
            dashes = [0, path.lineWidth * 2]
            path.lineCapStyle = .round
            break
        default:
            break
        }
        
        path.setLineDash(dashes, count: dashes.count, phase: 0.0)
        
        // Set color to line
        style.color.setStroke()
        
        path.stroke()
    }
    
    static func resizeAndCompressImage(image: UIImage, frame: CGRect, quality: CGFloat) -> UIImage? {
        // resize
        let resizeFactor = (3 * quality > 1) ? 3 * quality : 1
        let resizeImageSize = CGSize(width: frame.size.width * resizeFactor, height: frame.size.height * resizeFactor)
        
        UIGraphicsBeginImageContext(resizeImageSize)
        image.draw(in: CGRect(x: 0, y: 0, width: resizeImageSize.width, height: resizeImageSize.height))
        var compressedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // compression
        if let image = compressedImage, let jpegData = UIImageJPEGRepresentation(image, quality) {
            compressedImage = UIImage(data: jpegData)
        }
        return compressedImage
    }
}
