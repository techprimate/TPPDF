//
//  Color+CloseToEqual.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 16/11/2017.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

extension Color {

    /**
     Calculates the red, green, blue and alpha values in the range 0...1 and compares the values up to the decimal specified.

     - parameter color: The other `Color`
     - returns: `true` if difference is less than specified delta
     */
    internal func isClose(to color: Color, decimals: Int) -> Bool {
        var r1: CGFloat = 0
        var g1: CGFloat = 0
        var b1: CGFloat = 0
        var a1: CGFloat = 0

        var r2: CGFloat = 0
        var g2: CGFloat = 0
        var b2: CGFloat = 0
        var a2: CGFloat = 0

        getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)

        if outOfBounds(val1: r1, val2: r2, decimals: decimals) {
            return false
        } else if outOfBounds(val1: g1, val2: g2, decimals: decimals) {
            return false
        } else if outOfBounds(val1: b1, val2: b2, decimals: decimals) {
            return false
        } else if outOfBounds(val1: a1, val2: a2, decimals: decimals) {
            return false
        }

        return true
    }

    /**
     Checks if the difference between the given values is less than the given delta.

     - parameter val1: First value
     - parameter val2: Second value
     - parameter decimals:Number of decimal digits

     - returns: `true` if differnec is small enough, othewise `false`
     */
    private func outOfBounds(val1: CGFloat, val2: CGFloat, decimals: Int) -> Bool {
        let value1 = Decimal(Double(val1))
        let value2 = Decimal(Double(val2))
        let delta = 1 / pow(Decimal(10), decimals)

        let minimum = min(value1, value2)
        let maximum = max(value1, value2)

        if value1 != value2 {
            if maximum - minimum > delta {
                return true
            }
        }
        return false
    }

}
