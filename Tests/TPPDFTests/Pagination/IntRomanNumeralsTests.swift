//
//  IntRomanNumeralsTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.09.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Testing
@testable import TPPDF

struct IntRomanNumeralsTests {
    @Test(arguments: [
        (0, ""),
        (1, "I"),
        (2, "II"),
        (3, "III"),
        (4, "IV"),
        (5, "V"),
        (6, "VI"),
        (7, "VII"),
        (8, "VIII"),
        (9, "IX"),
        (10, "X"),
        (11, "XI"),
        (12, "XII"),
        (13, "XIII"),
        (14, "XIV"),
        (15, "XV"),
        (16, "XVI"),
        (17, "XVII"),
        (18, "XVIII"),
        (19, "XIX"),
        (20, "XX"),
        (21, "XXI"),
        (22, "XXII"),
        (23, "XXIII"),
        (24, "XXIV"),
        (25, "XXV"),
        (26, "XXVI"),
        (27, "XXVII"),
        (28, "XXVIII"),
        (29, "XXIX"),
        (30, "XXX"),
        (40, "XL"),
        (41, "XLI"),
        (42, "XLII"),
        (43, "XLIII"),
        (44, "XLIV"),
        (45, "XLV"),
        (46, "XLVI"),
        (47, "XLVII"),
        (48, "XLVIII"),
        (49, "XLIX"),
        (50, "L"),
        (51, "LI"),
        (52, "LII"),
        (53, "LIII"),
        (54, "LIV"),
        (55, "LV"),
        (56, "LVI"),
        (57, "LVII"),
        (58, "LVIII"),
        (59, "LIX"),
        (60, "LX"),
        (90, "XC"),
        (91, "XCI"),
        (92, "XCII"),
        (93, "XCIII"),
        (94, "XCIV"),
        (95, "XCV"),
        (96, "XCVI"),
        (97, "XCVII"),
        (98, "XCVIII"),
        (99, "XCIX"),
        (100, "C"),
        (200, "CC"),
        (300, "CCC"),
        (400, "CD"),
        (500, "D"),
        (600, "DC"),
        (700, "DCC"),
        (800, "DCCC"),
        (900, "CM"),
        (1000, "M"),
    ])
    func convertsIntegersToRomanNumerals(value: Int, expectedNumeral: String) {
        // Arrange
        let number = value

        // Act
        let numeral = number.romanNumerals

        // Assert
        #expect(numeral == expectedNumeral)
    }
}
