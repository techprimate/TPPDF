//
//  UIImage+Pixel.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 05/11/2017.
//

extension UIImage {

    var pixelExtractor: PixelExtractor {
        return PixelExtractor(img: self.cgImage!)
    }

    func pixelColor(at location: CGPoint) -> UIColor {
        return PixelExtractor(img: self.cgImage!).colorAt(x: Int(location.x), y: Int(location.y))
    }

}

/**
 https://stackoverflow.com/questions/35029672/getting-pixel-color-from-an-image-using-cgpoint
 */
class PixelExtractor: NSObject {

    let image: CGImage
    let context: CGContext?

    var width: Int {
        return image.width
    }

    var height: Int {
        return image.height
    }

    init(img: CGImage) {
        image = img
        context = PixelExtractor.createBitmapContext(cgImage: img)
    }

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
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        // create bitmap
        let context = CGContext(data: bitmapData, width: pixelsWide, height: pixelsHigh, bitsPerComponent: 8,
                                bytesPerRow: bitmapBytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)

        // draw the image onto the context
        let rect = CGRect(x: 0, y: 0, width: pixelsWide, height: pixelsHigh)
        context?.draw(cgImage, in: rect)

        return context!
    }

    func colorAt(x: Int, y: Int) -> UIColor {
        assert(0<=x && x<width)
        assert(0<=y && y<height)

        let data = context!.data!

        let offset = 4 * (y * width + x)

        let alpha = CGFloat(data.load(fromByteOffset: offset, as: UInt8.self)) / 255.0
        let red = CGFloat(data.load(fromByteOffset: offset+1, as: UInt8.self)) / 255.0
        let green = CGFloat(data.load(fromByteOffset: offset+2, as: UInt8.self)) / 255.0
        let blue = CGFloat(data.load(fromByteOffset: offset+3, as: UInt8.self)) / 255.0

        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)

        return color
    }

}
