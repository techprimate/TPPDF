//
//  UIGraphics+Hex.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 04/11/2017.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

extension Color {

    /**
     TODO: documentation
     */
    internal convenience init(hex: String) throws {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 1.0

        let scanner = Scanner(string: hex)
        var hexValue: CUnsignedLongLong = 0

        if scanner.scanHexInt64(&hexValue) {
            let length = hex.count

            switch length {
            case 3:
                red = CGFloat((hexValue & 0xF00) >> 8)   / 15.0
                green = CGFloat((hexValue & 0x0F0) >> 4)   / 15.0
                blue = CGFloat(hexValue & 0x00F)          / 15.0
            case 4:
                red = CGFloat((hexValue & 0xF000) >> 12) / 15.0
                green = CGFloat((hexValue & 0x0F00) >> 8)  / 15.0
                blue  = CGFloat((hexValue & 0x00F0) >> 4) / 15.0
                alpha = CGFloat(hexValue & 0x000F)         / 15.0
            case 6:
                red = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                blue  = CGFloat(hexValue & 0x0000FF)          / 255.0
            case 8:
                red = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                blue = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
            default:
                throw PDFError.invalidHexLength(length: length)
            }
        } else {
            throw PDFError.invalidHex(hex: hex)
        }

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    /**
     TODO: documentation
     */
    internal var hex: String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        var rgb = 0
        if alpha == 1.0 {
            rgb = (Int)(red * 255) << 16
            rgb |= (Int)(green * 255) << 8
            rgb |= (Int)(blue * 255) << 0

            return String(format: "#%06x", rgb)
        }

        rgb = (Int)(red * 255) << 24
        rgb |= (Int)(green * 255) << 16
        rgb |= (Int)(blue * 255) << 8
        rgb |= (Int)(alpha * 255) << 0

        return String(format: "#%08x", rgb)
    }
}
