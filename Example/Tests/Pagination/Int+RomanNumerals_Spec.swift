//
//  Int+RomanNumerals_Spec.swift
//  TPPDF_Example
//
//  Created by Philip Niedertscheider on 09/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class Int_RomanNUmerals_Spec: QuickSpec {

    override func spec() {
        describe("Int") {

            describe("RomanNumerals") {

                it("can convert itself into a roman numeral") {
                    expect(0.romanNumerals) == ""
                    expect(1.romanNumerals) == "I"
                    expect(2.romanNumerals) == "II"
                    expect(3.romanNumerals) == "III"
                    expect(4.romanNumerals) == "IV"
                    expect(5.romanNumerals) == "V"
                    expect(6.romanNumerals) == "VI"
                    expect(7.romanNumerals) == "VII"
                    expect(8.romanNumerals) == "VIII"
                    expect(9.romanNumerals) == "IX"

                    expect(10.romanNumerals) == "X"
                    expect(11.romanNumerals) == "XI"
                    expect(12.romanNumerals) == "XII"
                    expect(13.romanNumerals) == "XIII"
                    expect(14.romanNumerals) == "XIV"
                    expect(15.romanNumerals) == "XV"
                    expect(16.romanNumerals) == "XVI"
                    expect(17.romanNumerals) == "XVII"
                    expect(18.romanNumerals) == "XVIII"
                    expect(19.romanNumerals) == "XIX"

                    expect(20.romanNumerals) == "XX"
                    expect(21.romanNumerals) == "XXI"
                    expect(22.romanNumerals) == "XXII"
                    expect(23.romanNumerals) == "XXIII"
                    expect(24.romanNumerals) == "XXIV"
                    expect(25.romanNumerals) == "XXV"
                    expect(26.romanNumerals) == "XXVI"
                    expect(27.romanNumerals) == "XXVII"
                    expect(28.romanNumerals) == "XXVIII"
                    expect(29.romanNumerals) == "XXIX"
                    expect(30.romanNumerals) == "XXX"

                    expect(40.romanNumerals) == "XL"
                    expect(41.romanNumerals) == "XLI"
                    expect(42.romanNumerals) == "XLII"
                    expect(43.romanNumerals) == "XLIII"
                    expect(44.romanNumerals) == "XLIV"
                    expect(45.romanNumerals) == "XLV"
                    expect(46.romanNumerals) == "XLVI"
                    expect(47.romanNumerals) == "XLVII"
                    expect(48.romanNumerals) == "XLVIII"
                    expect(49.romanNumerals) == "XLIX"
                    expect(50.romanNumerals) == "L"

                    expect(51.romanNumerals) == "LI"
                    expect(52.romanNumerals) == "LII"
                    expect(53.romanNumerals) == "LIII"
                    expect(54.romanNumerals) == "LIV"
                    expect(55.romanNumerals) == "LV"
                    expect(56.romanNumerals) == "LVI"
                    expect(57.romanNumerals) == "LVII"
                    expect(58.romanNumerals) == "LVIII"
                    expect(59.romanNumerals) == "LIX"
                    expect(60.romanNumerals) == "LX"

                    expect(90.romanNumerals) == "XC"
                    expect(91.romanNumerals) == "XCI"
                    expect(92.romanNumerals) == "XCII"
                    expect(93.romanNumerals) == "XCIII"
                    expect(94.romanNumerals) == "XCIV"
                    expect(95.romanNumerals) == "XCV"
                    expect(96.romanNumerals) == "XCVI"
                    expect(97.romanNumerals) == "XCVII"
                    expect(98.romanNumerals) == "XCVIII"
                    expect(99.romanNumerals) == "XCIX"

                    expect(100.romanNumerals) == "C"
                    expect(200.romanNumerals) == "CC"
                    expect(300.romanNumerals) == "CCC"
                    expect(400.romanNumerals) == "CD"
                    expect(500.romanNumerals) == "D"

                    expect(600.romanNumerals) == "DC"
                    expect(700.romanNumerals) == "DCC"
                    expect(800.romanNumerals) == "DCCC"
                    expect(900.romanNumerals) == "CM"
                    expect(1000.romanNumerals) == "M"
                }
            }
        }
    }

}
