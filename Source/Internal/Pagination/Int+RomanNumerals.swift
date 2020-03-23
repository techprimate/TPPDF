//
//  Int+RomanNumeral.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 04/11/2017.
//

/**
 Extends an integer with conversion to Roman Numerals
 */
extension Int {

    /**
     Converts `self` into a string of roman numerals.
     */
    internal var romanNumerals: String {
        let romanValues = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
        let arabicValues = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]

        var romanValue = ""
        var startingValue = self

        for (index, romanChar) in romanValues.enumerated() {
            let arabicValue = arabicValues[index]
            let div = startingValue / arabicValue

            if div > 0 {
                for _ in 0..<div {
                    romanValue += romanChar
                }
                startingValue -= arabicValue * div
            }
        }

        return romanValue
    }
}
