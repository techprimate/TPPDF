//
//  UIImage+Pixel.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 05/11/2017.
//

extension UIImage {

    func getPixelColor(at location: CGPoint) -> UIColor {
        let width = self.size.width
        let pixelData = self.cgImage!.dataProvider!.data
        let data = CFDataGetBytePtr(pixelData)!

        let pixelIndex: Int = Int(4 * (location.y * width + location.x))

        let r = CGFloat(data[pixelIndex])     / CGFloat(255.0)
        let g = CGFloat(data[pixelIndex + 1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelIndex + 2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelIndex + 3]) / CGFloat(255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}
