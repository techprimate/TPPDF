//
//  UIImage+Pixel.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 05/11/2017.
//

#if os(iOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

/**
 TODO: documentation
 */
extension Image {
    /**
     TODO: documentation
     */
    var pixelExtractor: PixelExtractor {
        #if os(iOS)
            return PixelExtractor(img: cgImage!)
        #elseif os(macOS)
            var imageRect = CGRect(origin: .zero, size: size)
            let image = cgImage(forProposedRect: &imageRect, context: nil, hints: nil)!
            return PixelExtractor(img: image)
        #endif
    }

    /**
     TODO: documentation
     */
    func pixelColor(at location: CGPoint) -> Color {
        pixelExtractor.colorAt(x: Int(location.x), y: Int(location.y))
    }
}

/**
 https://stackoverflow.com/questions/35029672/getting-pixel-color-from-an-image-using-cgpoint
 TODO: documentation
 */
class PixelExtractor: NSObject {
    /**
     TODO: documentation
     */
    let image: CGImage

    /**
     TODO: documentation
     */
    let context: CGContext?

    /**
     TODO: documentation
     */
    var width: Int {
        image.width
    }

    /**
     TODO: documentation
     */
    var height: Int {
        image.height
    }

    /**
     TODO: documentation
     */
    init(img: CGImage) {
        self.image = img
        self.context = PixelExtractor.createBitmapContext(cgImage: img)
    }

    /**
     TODO: documentation
     */
    class func createBitmapContext(cgImage: CGImage) -> CGContext {
        // Get image width, height
        let pixelsWide = cgImage.width
        let pixelsHigh = cgImage.height

        let bitmapBytesPerRow = pixelsWide * 4
        let bitmapByteCount = bitmapBytesPerRow * Int(pixelsHigh)

        // Use the generic RGB color space.
        let colorSpace = CGColorSpaceCreateDeviceRGB()

        // Allocate memory for image data. This is the destination in memory
        // where any drawing to the bitmap context will be rendered.
        let bitmapData = malloc(bitmapByteCount)
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)
        let size = CGSize(width: pixelsWide, height: pixelsHigh)
        #if os(iOS)
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        #elseif os(macOS)
            // TODO: macOS support
        #endif

        // create bitmap
        let context = CGContext(data: bitmapData, width: pixelsWide, height: pixelsHigh, bitsPerComponent: 8,
                                bytesPerRow: bitmapBytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)

        // draw the image onto the context
        let rect = CGRect(x: 0, y: 0, width: pixelsWide, height: pixelsHigh)
        context?.draw(cgImage, in: rect)

        return context!
    }

    /**
     TODO: documentation
     */
    func colorAt(x: Int, y: Int) -> Color {
        assert(x >= 0 && x < width)
        assert(y >= 0 && y < height)

        let data = context!.data!

        let offset = 4 * (y * width + x)

        let alpha = CGFloat(data.load(fromByteOffset: offset, as: UInt8.self)) / 255.0
        let red = CGFloat(data.load(fromByteOffset: offset + 1, as: UInt8.self)) / 255.0
        let green = CGFloat(data.load(fromByteOffset: offset + 2, as: UInt8.self)) / 255.0
        let blue = CGFloat(data.load(fromByteOffset: offset + 3, as: UInt8.self)) / 255.0

        let color = Color(red: red, green: green, blue: blue, alpha: alpha)

        return color
    }
}
