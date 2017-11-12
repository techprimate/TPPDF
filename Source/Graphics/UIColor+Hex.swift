//
//  UIGraphics+Hex.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 04/11/2017.
//

extension UIColor {

    convenience init(hex: String) throws {
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        let scanner = Scanner(string: hex)
        var hexValue: CUnsignedLongLong = 0

        if scanner.scanHexInt64(&hexValue) {
            let length = hex.count

            switch length {
            case 3:
                r = CGFloat((hexValue & 0xF00) >> 8)   / 15.0
                g = CGFloat((hexValue & 0x0F0) >> 4)   / 15.0
                b = CGFloat(hexValue & 0x00F)          / 15.0
            case 4:
                r = CGFloat((hexValue & 0xF000) >> 12) / 15.0
                g = CGFloat((hexValue & 0x0F00) >> 8)  / 15.0
                b  = CGFloat((hexValue & 0x00F0) >> 4) / 15.0
                a = CGFloat(hexValue & 0x000F)         / 15.0
            case 6:
                r = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                g = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                b  = CGFloat(hexValue & 0x0000FF)          / 255.0
            case 8:
                r = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                g = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                b = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                a = CGFloat(hexValue & 0x000000FF)         / 255.0
            default:
                throw PDFError.invalidHexLength(length: length)
            }
        } else {
            throw PDFError.invalidHex(hex: hex)
        }

        self.init(red: r, green: g, blue: b, alpha: a)
    }

    var hex: String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        getRed(&r, green: &g, blue: &b, alpha: &a)

        var rgb = 0
        if a == 1.0 {
            rgb = (Int)(r * 255) << 16
            rgb |= (Int)(g * 255) << 8
            rgb |= (Int)(b * 255) << 0

            return String(format: "#%06x", rgb)
        } else {
            rgb = (Int)(r * 255) << 24
            rgb |= (Int)(g * 255) << 16
            rgb |= (Int)(b * 255) << 8
            rgb |= (Int)(a * 255) << 0

            return String(format: "#%08x", rgb)
        }
    }
}
